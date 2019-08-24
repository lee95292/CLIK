#include<stdio.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<arpa/inet.h>
#include<stdlib.h>
#include<string.h>
#include<unistd.h>
#include<fcntl.h>

#define PORTNUM 18081
#define BUF_SIZE 256
int main(int argc,char** argv)
{
    if(argc<2){
        perror("invalid_argument");
        exit(1);
    }
    int sd;
    char buf[256];
    char buf2[256];

    struct sockaddr_in sin;

    memset((char*)&sin, '\0', sizeof(sin));
    sin.sin_family=AF_INET;
    sin.sin_port=htons(PORTNUM);
    sin.sin_addr.s_addr=inet_addr("192.168.0.7");

    if((sd=socket(AF_INET,SOCK_STREAM,0))==-1){
        perror("socket");
        exit(1);
    }

    if(connect(sd,(struct sockaddr*)&sin, sizeof(sin)))
    {
        perror("connect");
        exit(1);
    }
    
    sprintf(buf,"%s %s",argv[1],argv[2]);
    if(send(sd,buf,BUF_SIZE,0)==-1)
    {
        perror("send");
        exit(1);
    }
    printf("debug :request ended\n\n");
    /*while(strcmp("exit\0",buf)!=0)
    {
        printf(">>");
        fgets(buf,100,stdin);
        //fflush(buf);
        if(send(sd,buf,BUF_SIZE,0)==-1)
        {
            perror("send");
            exit(1);
        }

        if(recv(sd,buf2,BUF_SIZE,0)==-1)
        {
            perror("recv");
            exit(1);
        }
        //printf("[ ]: %s\n",buf2);
    }*/

    close(sd);
    exit(0);
}
