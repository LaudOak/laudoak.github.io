---
layout: post
title: "MySQL Privilege"
categories: Server
---
###查看用户所拥有大权限

```
show grants for laudoak;
```

###EXPLAIN理解查询操作的工作过程

```
explain `table`;
explain select title from books;
```

###数据库备份
    * 复制数据库文件锁定表
```
lock tables `table` `lock_type`(READ || WRITE);
```

    * 操作系统命令行下

```
myslqdump --opt --all-databases > all.sql;
```
