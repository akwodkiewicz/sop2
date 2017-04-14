#define _GNU_SOURCE
#include "soplib.h"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <signal.h>
#include <netdb.h>
#include <time.h>

#define PORT "5522"
#define MAX_TRIES 3

int main(int argc, char **argv) 
{
    int                 tries=0;
    int                 sock;
    int                 ret;
    struct addrinfo    *serv_info;
    struct sockaddr_in  dest_addr;
 
    if((ret = getaddrinfo(argv[1], PORT, NULL, &serv_info))<0)
    {
        fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(ret));
        exit(EXIT_FAILURE);
    }
    dest_addr = *(struct sockaddr_in *)(serv_info[0].ai_addr);
    //======= Just for debug purposes ========
    char *ip_addr = inet_ntoa(dest_addr.sin_addr);
    fprintf(stderr, "\nConnecting to: %s:%hu\n", \
        ip_addr,ntohs(dest_addr.sin_port));
    //========================================
    freeaddrinfo(serv_info);

    if((sock = socket(PF_INET, SOCK_STREAM, 0))<0)
        err("socket");
    if(connect(sock, (struct sockaddr *)&dest_addr, sizeof(struct sockaddr_in))<0)
        err("connect");

    srand(time(NULL));
    while(tries++ < MAX_TRIES)
    {
        int32_t number = rand()%1000 + 1;
        int32_t max_number;
        if(bulk_write(sock, (char *)&number, sizeof(int32_t))<0)
            err("bulk_write");
        if(bulk_read(sock, (char *)&max_number, sizeof(int32_t))<0)
            err("bulk_read");
        if(number == max_number)
        {
            fprintf(stderr, "=== I've sent the biggest number: %d ===\n", number);
        }
        nsleep(2, 500, 0, 0);
    }
    if(close(sock)<0)
        err("close"); 

    fprintf(stderr, "Client is exiting.\n");
}

   //Get socket address from host and port
    /*
        struct sockaddr_in {
                     short sin_family; (AF_INET)
            unsigned short sin_port;   (PORT==5522)
            struct in_addr sin_addr;
        }
        struct in_addr {
            unsigned long s_addr; //real IP set with inet_aton("192...", &dest)
        }
    */
