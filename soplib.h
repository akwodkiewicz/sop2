#ifndef SOPLIB_H
#define SOPLIB_H
#endif
#include <sys/types.h>

void err(char* src);
void usage(char * msg);
int sethandler( void (*f)(int), int sigNo);
void nsleep(int s, int ms, int us, int ns);
ssize_t bulk_read(int fd, char *buf, size_t count);
ssize_t bulk_write(int fd, char *buf, size_t count);


