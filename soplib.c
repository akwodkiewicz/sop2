#define _GNU_SOURCE
#include "soplib.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
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
ssize_t bulk_read(int fd, char *buf, size_t count)
{
    int c;
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
    int c;
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
void nsleep(int s, int ms, int us, int ns)
{
    struct timespec t;
    t.tv_sec = s;
    t.tv_nsec = ns+1000*us+1000000*ms;
    nanosleep(&t, NULL);
}