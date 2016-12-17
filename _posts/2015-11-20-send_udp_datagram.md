---
layout: post
title: Send and receive UDP datagram
categories: 云雀
---

## 服务器端代码：

```c
#include <stdio.h>      /* 标准输入输出头文件 */
#include <netinet/in.h> /* 互联网地址族 */
#include <arpa/inet.h>  /* LINUX下C语言程序的INTERNET定义头文件 */
#include <unistd.h>     /* 符号常量 */
#include <fcntl.h>      /* 文件控制 */
#include <sys/stat.h>   /* 文件状态 */
#include <sys/types.h>  /* 基本系统数据类型 */
#include <sys/socket.h> /* 套接字接口 */
#define LOCALPORT 4567
/* 定义本地服务器端口 */
int main( int argc, char *argv[] )
{
	int			s, len;
	struct sockaddr_in	addr;
	int			addr_len;
	char			msg[256];
	int			i = 0;
/*
 * 编写一个函数用来初始化套接字和绑定套接字。
 * 初始化套接字。socket参数第一个是网络套接字族。一般都是AF_INET。
 * 第二个参数是套接字类型。TCP的是SOCK_STREAM。
 * UDP的是SOCK_DGRAM的形式。
 * 第三个是初始化的协议。一般都是0。
 */
	if ( (s = socket( AF_INET, SOCK_DGRAM, 0 ) ) < 0 )
	{
		perror( "error" );
		exit( 1 );
	}else  {
		printf( "socket created .\n" );
		printf( "socked id: %d \n", s );
		printf( "remote port: %d \n", LOCALPORT );
/* 创建成功后输出信息。 */
	}
	len = sizeof(struct sockaddr_in);
	bzero( &addr, sizeof(addr) );
	addr.sin_family		= AF_INET;              /* 地址家族。 */
	addr.sin_port		= htons( LOCALPORT );   /* 端口。这个port是自己申明的变量，一般自己申明的端口号要大于1024。 */
	addr.sin_addr.s_addr	= htonl( INADDR_ANY );  /* 地址是一个结构体。用htonl把它转化为网络字节序。 */
	if ( bind( s, (struct sockaddr *) &addr, sizeof(addr) ) < 0 )
	{
		perror( "connect..." );
		exit( 1 );
	}else  { printf( "bind ok. \n" );
		 printf( "local port:%d \n", LOCALPORT ); } /* 绑定套接字。 */
	while ( 1 )
	{
		bzero( msg, sizeof(msg) );
		len = sizeof(struct sockaddr_in);
/*
 * 因为我们是用UDP的方式。所以我们这里用recvform来接收数据。若是TCP则采用recv。
 * recvform的参数。第一是套接字，第二个是你要接收的字符缓冲区。
 * 第三个是缓冲区大小。第四个是标记我们设为0就好。
 * 第五个参数是接收对方地址。第六个是地址长度。
 */
		if ( (i = recvfrom( s, msg, sizeof(msg), 0, (struct sockaddr *) &addr, &len ) ) == -1 )
		{
			printf( "error receiving! \n" );
			exit( 1 );
		}
		if ( !strcmp( "quit\n", msg ) )         /* 如果收到“quit”，表示客户端要结束聊天。 */
		{
			sendto( s, msg, sizeof(msg), 0, (struct sockaddr *) &addr, len );
			printf( "Chat end!\n" );        /*服务器发送“quit”并结束，输出Chat end!。 */
			break;
		}
		printf( "The mseeage you recving is:%s \n", msg );
		sendto( s, msg, sizeof(msg), 0, (struct sockaddr *) &addr, len );
	}
}
```

## 客户端源代码：

```c
#include <stdio.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/socket.h>
#define REMOTEPORT	4567 /* 直接定义连接服务器端口。 */
#define REMOTEIP	"127.0.0.1"
int main( int argc, char *argv[] )
{
	int			s, len;
	struct sockaddr_in	addr;
	int			addr_len;
	char			msg[256];
	int			i = 0;
/* 定义套接字并初始化，建立成功则输出信息。 */
	if ( (s = socket( AF_INET, SOCK_DGRAM, 0 ) ) < 0 )
	{
		perror( "error" );
		exit( 1 );
	}else  {
		printf( "socket created .\n" );
		printf( "socked id: %d \n", s );
		printf( "remote ip: %s \n", REMOTEIP );
		printf( "remote port: %d \n", REMOTEPORT );
	}
	len = sizeof(struct sockaddr_in);
	bzero( &addr, sizeof(addr) );
	addr.sin_family		= AF_INET;
	addr.sin_port		= htons( REMOTEPORT );
	addr.sin_addr.s_addr	= inet_addr( REMOTEIP );
	while ( 1 )
	{
		bzero( msg, sizeof(msg) );
		len = read( STDIN_FILENO, msg, sizeof(msg) );
		if ( (sendto( s, msg, sizeof(msg), 0, &addr, sizeof(addr) ) ) < 0 )
		{
			perror( "send message worry!" );
			exit( 1 );
		}
		printf( "send message is:%s\n", msg );
	}
}
```