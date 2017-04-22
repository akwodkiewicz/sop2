#define _GNU_SOURCE
#include "soplib.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <time.h>


void usage(char * msg)
{
    fprintf(stderr, "USAGE: %s\n", msg);

}
void err(char *source)
{
    perror(source);
    fprintf(stderr,"%s:%d\n",__FILE__,__LINE__);
    exit(EXIT_FAILURE);
}
int sethandler( void (*f)(int), int sigNo)
{
    struct sigaction act;
    memset(&act, 0, sizeof(struct sigaction));
    act.sa_handler = f;
    if (-1==sigaction(sigNo, &act, NULL))
        return -1;
    return 0;
}
void nsleep(int s, int ms, int us, int ns)
{
    struct timespec t;
    t.tv_sec = s;
    t.tv_nsec = ns+1000*us+1000000*ms;
    nanosleep(&t, NULL);
}
ssize_t bulk_read(int fd, char *buf, size_t count)
{
    int    c;
    size_t len=0;
    do{
        c=TEMP_FAILURE_RETRY(read(fd,buf,count));
        if(c<0) return c;
        if(0==c) return len;
        buf+=c;
        len+=c;
        count-=c;
    }while(count>0);
    return len ;
}
ssize_t bulk_write(int fd, char *buf, size_t count)
{
    int    c;
    size_t len=0;
    do{
        c=TEMP_FAILURE_RETRY(write(fd,buf,count));
        if(c<0) return c;
        buf+=c;
        len+=c;
        count-=c;
    }while(count>0);
    return len ;
}
int bindinet(uint16_t port, int type)
{
    int                sock;
    int                val=1;
    struct sockaddr_in addr;
    
    sock = socket(PF_INET, type, 0);
    if(sock<0)
        err("socket");
    memset(&addr, 0, sizeof(struct sockaddr_in));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);
    addr.sin_addr.s_addr = htonl(INADDR_ANY);
    if(setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val)))
        err("setsockopt");
    if(bind(sock, (struct sockaddr*)&addr, sizeof(addr))<0)
        err("bind");
    return sock;
}
struct sockaddr_in makeaddress(char *address, char *port)
{
    int                 ret;
    struct sockaddr_in  addr;
    struct addrinfo    *result;
    struct addrinfo     hints = {};
    hints.ai_family = AF_INET;
    if((ret=getaddrinfo(address, port, &hints, &result)))
    {
        fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(ret));
        exit(EXIT_FAILURE);
    }
    addr = *(struct sockaddr_in *)(result->ai_addr);
    freeaddrinfo(result);
    return addr;
}