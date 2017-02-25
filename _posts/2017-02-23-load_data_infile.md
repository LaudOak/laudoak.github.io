---
layout: post
title: MySQL LOAD DATA数据导入记录
category: 数据库
---

把主机A上8.1G数据导出的TXT文件导入到主机B的数据库中

### LOAD DATA INFILE命令:快速从文本文件读取行插入到数据表中

```
LOAD DATA [LOW_PRIORITY | CONCURRENT] [LOCAL] INFILE 'file_name'
    [REPLACE | IGNORE]
    INTO TABLE tbl_name
    [PARTITION (partition_name,...)]
    [CHARACTER SET charset_name]
    [{FIELDS | COLUMNS}
        [TERMINATED BY 'string']
        [[OPTIONALLY] ENCLOSED BY 'char']
        [ESCAPED BY 'char']
    ]
    [LINES
        [STARTING BY 'string']
        [TERMINATED BY 'string']
    ]
    [IGNORE number {LINES | ROWS}]
    [(col_name_or_user_var,...)]
    [SET col_name = expr,...]
```

 - `LOAD DATA INFILE`是`SELECT ... INTO OUTFILE`语句的互补，使用SELECT ... INTO OUTFILE把数据从表写到文件，
 想读回到表里使用LOAD DATA INFILE;

 - `LOW_PRIORITY`选项在没有客户端读取表内容是才执行LOAD DATA,在仅使用表级锁的存储引擎上起作用(such as MyISAM, MEMORY, and MERGE);

 - `CONCURRENT`,使用MyISAM的表声明CONCURRENT后可以实现并行插入(即其中没有空闲时间),当LOAD DATA时其他线程可以检索数据,这个选项对LOAD DATA
 性能有很小的影响,即使没有其他线程使用该表;

 - `LOCAL`,LOCAL属性在客户或服务机配置允许情况下生效.例如当mysqld以--local-infile=0(my.cnf)方式启动,LOCAL属性将不能正常工作.
 没有声明LOCAL时,文件必须位于服务端并且直接被服务端读取;声明LOCAL时文件被客户端读取并发送给服务器端,此时服务器端会创建一份文件拷贝.


### LOAD DATA过程

 - 在A主机上解压data.tar.gz得到data.txt导出的TXT文件

```
tar -xzvf data.tar.gz
```

 - LOAD DATA

```
load data local infile "~/data.txt"
into table `tmp`(`xxx`,`xxx`,`xxx`,`xxx`);
```

中途出现错误

```
ERROR 2013 (HY000): Lost connection to MySQL server during query
```

原因是查询超时,通过设置超时时长解决(默认60s)

```
SET @@local.net_read_timeout=360;
```

最后导入结果

```
Query OK, 0 rows affected, 65535 warnings (7 min 17.01 sec)
Records: 38729917  Deleted: 0  Skipped: 38729917  Warnings: 312088551
```

WARNING原因是PAIMARY KEY冲突和空字符与字段int类型不匹配

```
+---------+------+----------------------------------------------------------------------------+
| Level   | Code | Message                                                                    |
+---------+------+----------------------------------------------------------------------------+
| Warning | 1366 | Incorrect integer value: '' for column 'xxx' at row 1      |
| Warning | 1062 | Duplicate entry '1' for key 'PRIMARY'                                      |
```

 - 接着使用scp(secure copy)进行跨机远程拷贝,把A主机的备份压缩文件拷贝到B主机上

从本机器推文件到远程机器上:

```
scp /root/data.txt  root@10.10.10.10:/root/data.txt 
```

 - 在主机B上导入备份

 ```
LOAD DATA CONCURRENT LOCAL 
INFILE "/root/data.txt"
into table `tmp`(`xxx`,`xxx`,`xxx`,`xxx`);
 ```

 - 在主机B上导入时,表结构已经做了更改,InnoDB换为MyISAM,相对InNoDB导入速度提高了;同时表新增了自增主键,相对同表结构导入速度下降

### 参考

- [MySQL 5.7 Reference Manual  /  ...  /  LOAD DATA INFILE Syntax](https://dev.mysql.com/doc/refman/5.7/en/load-data.html)

- [Docs » 工具参考篇 » 18. scp 跨机远程拷贝](http://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/scp.html?highlight=scp#scp)

- [lost-connection-to-mysql-server-during-query](http://stackoverflow.com/questions/6516943/lost-connection-to-mysql-server-during-query)

- [error-1148-the-used-command-is-not-allowed-with-this-mysql-version](http://stackoverflow.com/questions/18437689/error-1148-the-used-command-is-not-allowed-with-this-mysql-version)

- [mysql-enable-load-data-local-infile](http://stackoverflow.com/questions/10762239/mysql-enable-load-data-local-infile)