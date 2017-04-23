---
layout: post
title: First step of Docker
category: Java
---

## CentOS install Maven

reference:

[http://www.jianshu.com/p/c36fb8d80157](http://www.jianshu.com/p/c36fb8d80157)

[http://blog.csdn.net/clementad/article/details/46898013](http://blog.csdn.net/clementad/article/details/46898013)

[http://maven.apache.org/download.cgi](http://maven.apache.org/download.cgi)

- wget http://mirrors.hust.edu.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz

- tar xvf apache-maven-3.3.9-bin.tar.gz

- mv apache-maven-3.3.9 /usr/local/
 
- vi /etc/profile

```
export MAVEN_HOME=/usr/local/webserver/apache-maven-3.3.9
export PATH=${MAVEN_HOME}/bin:${PATH}
```

- source /etc/profile

- mvn -v

```
which: no javac in (/usr/local/apache-maven-3.3.9/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin)
which: no java in (/usr/local/apache-maven-3.3.9/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin)
Error: JAVA_HOME is not defined correctly.
  We cannot execute
```

## CentOS install jdk

reference:

[https://www.digitalocean.com/community/tutorials/how-to-install-java-on-centos-and-fedora](https://www.digitalocean.com/community/tutorials/how-to-install-java-on-centos-and-fedora)

[http://www.jianshu.com/p/848b06dd19aa](http://www.jianshu.com/p/848b06dd19aa)

[http://www.oracle.com/technetwork/java/javase/downloads/index.html](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

- wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.rpm"

 - sudo yum localinstall jdk-8u121-linux-x64.rpm


## CentOS install Docker

reference:
[https://yeasy.gitbooks.io/docker_practice/content/](https://yeasy.gitbooks.io/docker_practice/content/)

 - curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -

 - sudo systemctl enable docker

 - $ sudo systemctl start docker

