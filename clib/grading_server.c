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
#define BUF_SIZE 64

int cntReady(int* , struct sockaddr_in* );	//connection Ready

int main()
{
	char buf[BUF_SIZE];
	char cmdbuf[256];
	char* tmpbuf;
	char ipaddr[BUF_SIZE];
	char hostname[BUF_SIZE];
	struct sockaddr_in sin, cli;
	int sd, ns, slen, clientlen=sizeof(cli),status;
	pid_t pid;

	memset((char*)&sin,'\0',sizeof(sin));
	sin.sin_family=AF_INET;
	sin.sin_port=htons(PORTNUM);
	sin.sin_addr.s_addr = inet_addr("192.168.0.7");
	
	if(cntReady(&sd,&sin)==-1)
		exit(1);
	
	while(1)
	{
		if((ns=accept(sd,(struct sockaddr*)&cli, &clientlen))==-1){
			perror("accept");
			exit(1);
		}
		
		printf("new client accepted\n");

		sprintf(ipaddr,"%s",inet_ntoa(cli.sin_addr));
		switch(pid=fork()){

			case 0:	
				close(sd);
				while(recv(ns,buf,BUF_SIZE,0)!=-1){
						
					printf("client accepted IP: %s\n",ipaddr);
					tmpbuf=strtok(buf," ");
					// 1_request message (request hostname)
					// 2_result message (result ipaddr)
					if(strcmp(tmpbuf,"request")==0){
						tmpbuf=strtok(NULL," ");
						sprintf(hostname,"%s",tmpbuf);
					        sprintf(cmdbuf,"~/clik/utils/response.sh %s",ipaddr);
						printf("debug: hostname %s\n\n",hostname);

						system(cmdbuf);
					
					}else if(strcmp(tmpbuf,"result")==0){
						tmpbuf=strtok(NULL," ");
						printf("hostname : %s",hostname);
						sprintf(cmdbuf,"echo $(date) __%s__ > ~/clik/data/%s.log",tmpbuf,hostname);
						printf("debug cmdbuf - %s\n",cmdbuf);
						system(cmdbuf);
						break;
					}else{
						printf("Wrong request: %s\n",tmpbuf);
						break;
					}
				}
			
		}		
		close(ns);	
	}
	
}

int cntReady(int* sd, struct sockaddr_in* sin)
{
	if((*sd=socket(AF_INET,SOCK_STREAM,0))==-1)
	{
		perror("socket");
		return -1;
	}

	if(bind(*sd, (struct sockaddr*)sin,sizeof(*sin)))
	{
		perror("bind");
		return -1;
	}

	printf("listening..\n");
	if(listen(*sd,5)){
		perror("listen");
		return -1;
	}
	printf("listening...\n");

	return 1;
	
}
