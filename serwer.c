#define _GNU_SOURCE 
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <sys/time.h>
#include <netinet/in.h>
#include <signal.h>
#include <netdb.h>
#include <fcntl.h>
#include <arpa/inet.h>

#include "soplib.h"

#define PORT 5522
#define BACKLOG 3
#define MAX_TRIES 3
#define MAX_CLIENTS 100

volatile sig_atomic_t quit_flag = 0;

void siginthandler(int sigNo);
void serverroutine(int listen_sock);

int main(int argc, char** argv) 
{
    int                 listen_sock;
    int                 flags;
    int                 optval = 1;
    struct sockaddr_in  server_addr;
    
    if(argc!=1) 
    {
        usage(argv[0]);
        return EXIT_FAILURE;
    }
    sethandler(siginthandler, SIGINT);
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(PORT);
    server_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    memset(&(server_addr.sin_zero), 0, 8);
    //Creating a socket
    if((listen_sock = socket(PF_INET, SOCK_STREAM, 0))<0)
        err("socket");
    //Changing the socket to non-blocking for pselect()use
    flags = fcntl(listen_sock, F_GETFL)|O_NONBLOCK;
    fcntl(listen_sock, F_SETFL, flags);
    //Changing socket to reusable
    setsockopt(listen_sock, SOL_SOCKET, SO_REUSEADDR, &optval, sizeof(int));
    //Setting the socket address
    if(bind(listen_sock, &server_addr, sizeof(struct sockaddr_in))<0)
        err("bind");
    //Setting socket to listening mode
    if(listen(listen_sock, BACKLOG)<0)
        err("listen");

    serverroutine(listen_sock);


    close(listen_sock);
    fprintf(stderr, "=== Server is shutting down ===\n");
    return EXIT_SUCCESS;
}

void serverroutine(int listen_sock)
{
    int                 curr_sock;
    int                 client_socks[MAX_CLIENTS];
    int                 active_clients = 0;
    int                 count_tries = 0;
    int                 max_socket = listen_sock;
    int                 ready;
    unsigned int        sockin_size = sizeof(struct sockaddr_in);
    struct sockaddr_in  client_addr;
    sigset_t            mask;
    sigset_t            old_mask;
    fd_set              read_set;
    fd_set              base_read_set;
    int32_t             number;
    int32_t             max_number = 0;

    FD_ZERO(&base_read_set);
    FD_SET(listen_sock, &base_read_set);

    sigemptyset(&mask);
    sigaddset(&mask, SIGINT);
    sigprocmask(SIG_BLOCK, &mask, &old_mask);
    /*From now on - only during the time pselect() is working (in blocking mode)
    can we get a SIGINT - making the pselect fail and set errno==EINTR*/
    while(!quit_flag)
    {
        read_set = base_read_set;
        number=0;
        if((ready = pselect(max_socket+1, &read_set, NULL, NULL, NULL, &old_mask)>0))
        {
            if(FD_ISSET(listen_sock, &read_set))
            {
                FD_CLR(listen_sock, &read_set);                              
                ready--;
                if((curr_sock = accept(listen_sock, (struct sockaddr *)&client_addr, &sockin_size))<0)
                    err("accept");
                fprintf(stderr, 
                    "Server connected with a new client: %s:%hu\n",\
                    inet_ntoa(client_addr.sin_addr),ntohs(client_addr.sin_port));  
                client_socks[active_clients++] = curr_sock;
                FD_SET(curr_sock, &base_read_set);
                if(curr_sock>max_socket)
                    max_socket = curr_sock;
            }
            for(int i=0; i<active_clients && ready>0; i++)
            {
                if(FD_ISSET(client_socks[i], &read_set))
                {
                    curr_sock = client_socks[i];
                    ready--;
                    if(bulk_read(curr_sock, (char *)&number, sizeof(int32_t))<0)
                        err("bulk_read");
                    if(number==0)
                    {   
                        FD_CLR(client_socks[i], &base_read_set);
                        client_socks[i]=client_socks[--active_clients];
                        --i;
                        continue;
                    }
                    fprintf(stderr, "=== Received a message ===\nNUMBER: %d\nCURRENTSOCK: %d\n",
                        number, curr_sock);
                    if(number>max_number)
                        max_number = number;
                    if(bulk_write(curr_sock, (char *)&max_number, sizeof(int32_t))<0)
                        err("bulk_write");
                    count_tries++; 
                }
            } 
        }
        else
        {
            if(errno==EINTR)
                continue;
            err("pselect");
        }
    } 
    sigprocmask(SIG_UNBLOCK, &mask, NULL);
    for(int i=0; i<active_clients; i++)
        close(client_socks[i]);
    fprintf(stderr, "\n===== COUNTED:  %d NUMBERS =====\n", count_tries);
}

void siginthandler(int sigNo)
{
    quit_flag = 1;
}