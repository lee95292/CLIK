#include<stdio.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<arpa/inet.h>
#include<stdlib.h>
#include<string.h>
#include<unistd.h>
#include<fcntl.h>
#include<wait.h>

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
	sin.sin_addr.s_addr = inet_addr("192.168.0.254");
	
	if(cntReady(&sd,&sin)==-1)
		exit(1);
	
	while(1)
	{
		if((ns=accept(sd,(struct sockaddr*)&cli, &clientlen))==-1){
			perror("accept");
			exit(1);
		}
		

		sprintf(ipaddr,"%s",inet_ntoa(cli.sin_addr));
		switch(pid=fork()){

			case 0:	
				close(sd);
				if(1!=recv(ns,buf,BUF_SIZE,0)){
					perror("recv");
				}
				printf("client accepted IP:%s requset message:%s\n\n",ipaddr,buf);
				tmpbuf=strtok(buf," ");
				// 1_request message (request hostname AssignmentNumber)
				// 2_result message (result correct hostname AssignmentNumber)
				if(strcmp(tmpbuf,"request")==0){
					tmpbuf=strtok(NULL," ");	//hostname 분리				
					sprintf(hostname,"%s",tmpbuf);
				        sprintf(cmdbuf,"~/CLIK/utils/response.sh %s",ipaddr);

					tmpbuf=strtok(NULL," ");
					sprintf(cmdbuf,"%s %s",cmdbuf,tmpbuf);
					printf("Debug: cmdbuf: %s\n",cmdbuf);

					system(cmdbuf);
				}else if(strcmp(tmpbuf,"result")==0){
					tmpbuf=strtok(NULL," ");		//correct 분리
					sprintf(cmdbuf,"~/CLIK/data/processResult.sh %s %s",ipaddr,tmpbuf);

					tmpbuf =strtok(NULL," ");		// hostname 분리
					sprintf(cmdbuf,"%s %s",cmdbuf,tmpbuf);

					tmpbuf=strtok(NULL," ");		//AssignmentNumber 분리
					sprintf(cmdbuf,"%s %s",cmdbuf,tmpbuf);

					printf("debug cmdbuf - %s\n",cmdbuf);
					system(cmdbuf);
				}else{
					printf("Wrong request: %s\n",tmpbuf);
				}
				exit(0);
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
