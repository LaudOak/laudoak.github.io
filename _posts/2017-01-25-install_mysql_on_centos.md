---
layout: post
title: CentOS安装MySQL
category: 数据库
---

references:

[Installing MySQL on Linux Using the MySQL Yum Repository](https://dev.mysql.com/doc/refman/5.7/en/linux-installation-yum-repo.html)

## 步骤:

### 添加MySQL Yum Repository

 - 到[MySQL Yum Repository Page](https://dev.mysql.com/downloads/repo/yum/)下载对应平台的包

```
yum install wget
wget http://repo.mysql.com/mysql57-community-release-el7-9.noarch.rpm
```

 - 安装下载好的包

```
sudo yum localinstall platform-and-version-specific-package-name.rpm
sudo yum localinstall mysql57-community-release-el7-9.noarch.rpm
```

安装命令将添加MySQL Yum仓库到系统仓库列表并且下载[GnuPG key](https://dev.mysql.com/doc/refman/5.7/en/checking-gpg-signature.html)以检查软件包的完整性

使用以下命令检查仓库是否成功添加(在启用dnf的系统中用dnf替代yum)

```
yum repolist enabled | grep "mysql.*-community.*"
```

> Once the MySQL Yum repository is enabled on your system, any system-wide update by the yum update command (or dnf upgrade for dnf-enabled systems) will upgrade MySQL packages on your system and also replace any native third-party packages, if Yum finds replacements for them in the MySQL Yum repository; see Section 2.11.1.2, [“Upgrading MySQL with the MySQL Yum Repository”](https://dev.mysql.com/doc/refman/5.7/en/updating-yum-repo.html) and, for a discussion on some possible effects of that on your system, see [Upgrading the Shared Client Libraries](https://dev.mysql.com/doc/refman/5.7/en/updating-yum-repo.html#updating-yum-repo-client-lib).


### 选择一个发行版本

使用MySQL Yum仓库,最新的正式发行版被默认选中用以安装,安装最新发行版本时不需要额外配置,否则在安装之前需要禁用最新发行版本子仓库并启用指定版本子仓库

 - 查看所有MySQL Yum仓库中的子仓库

```
yum repolist all | grep mysql

[root]# yum repolist all | grep mysql
Repository epel is listed more than once in the configuration
mysql-connectors-community/x86_64 MySQL Connectors Community        启用:     30
mysql-connectors-community-source MySQL Connectors Community - Sour 禁用
mysql-tools-community/x86_64      MySQL Tools Community             启用:     40
mysql-tools-community-source      MySQL Tools Community - Source    禁用
mysql-tools-preview/x86_64        MySQL Tools Preview               禁用
mysql-tools-preview-source        MySQL Tools Preview - Source      禁用
mysql55-community/x86_64          MySQL 5.5 Community Server        禁用
mysql55-community-source          MySQL 5.5 Community Server - Sour 禁用
mysql56-community/x86_64          MySQL 5.6 Community Server        禁用
mysql56-community-source          MySQL 5.6 Community Server - Sour 禁用
mysql57-community/x86_64          MySQL 5.7 Community Server        启用:    166
mysql57-community-source          MySQL 5.7 Community Server - Sour 禁用
mysql80-community/x86_64          MySQL 8.0 Community Server        禁用
mysql80-community-source          MySQL 8.0 Community Server - Sour 禁用
```

 - 指定子仓库的启用和禁用(使用yum-config-manager or dnf config-manager)

```
shell> sudo yum-config-manager --disable mysql57-community
shell> sudo yum-config-manager --enable mysql56-community
```

 - 指定子仓库的启用和禁用(更改/etc/yum.repos.d/mysql-community.repo文件)

在文件中找到子仓库配置并编辑enabled选项,enabled=0 to disable a subrepository, or enabled=1 to enable a subrepository. 

```
 # Enable to use MySQL 5.6
[mysql56-community]
name=MySQL 5.6 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.6-community/el/6/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
```

### 安装MySQL

```
shell> sudo yum install mysql-community-server
```

This installs the package for MySQL server (mysql-community-server) and also packages for the components required to run the server, including packages for the client (mysql-community-client), the common error messages and character sets for client and server (mysql-community-common), and the shared client libraries (mysql-community-libs).

### 启动MySQL服务

 - 启动

```
shell> sudo service mysqld start
```

 - 查看MySQL服务状态 

```
shell> sudo service mysqld status
```

 - 更改root账号密码

 超级用户账号'root'@'localhost'将被创建,密码存放在错误日志里,使用下面的命令找出密码

 ```
 shell> sudo grep 'temporary password' /var/log/mysqld.log
 ```

 更改密码

```
shell> mysql -uroot -p 

mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!';
```

>MySQL's validate_password plugin is installed by default. This will require that passwords contain at least one upper case letter, one lower case letter, one digit, and one special character, and that the total password length is at least 8 characters.

