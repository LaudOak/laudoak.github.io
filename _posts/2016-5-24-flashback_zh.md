---
layout: post
title: Oracle Flashback Technology ZH
category: 数据库
---

# Oracle Flashback Technology(ZH)

## 概览
> Oracle闪回技术是一组可以让你在不依赖时间点为介质复原数据库而能够看到数据库对象过去的状态，或者将数据库对象回溯到先前状态的Oracle数据库特性。

**使用这些特性，你可以做到以下几点：**

* 执行一些返回过去的数据的查询语句
* 执行并且返回对数据库作变更的详细历史的元数据的查询语句
* 恢复表或行到之前的某个时间点
* 自动跟踪并且对事务数据的变化进行存档
* 在数据库保持联机状态时回滚事务及其相关事务

**闪回技术提供了6种不同的方式 跟踪并通过不同的方法修复逻辑损坏。**

* Oracle的闪回查询功能，可以让你指定一个目标时间后运行你的查询语句，这样就可以查看数据库在给定的时间的数据内容。
* Oracle闪回版本查询，可以查看在规定的过去时间间隔里存在于在一个或多个表的所有版本的行。
* Oracle闪回事务查询，您可以查看在一个单独的事务中所做的更改，或在某一段时间内的所有事务。
* Oracle闪回表返回过去时间点的某个表状态。
* Oracle闪回删除是DROP TABLE的逆操作。
* Oracle闪回数据库提供了一种更有效的方法来替代依赖时间点的数据库恢复。


## 闪回数据库

* 拥有有SYSDBA权限 
* 必须预先设置闪回恢复区

```sql
show parameter db_recovery_file;
```

* 在V $ DATABASE视图的FLASHBACK_ON列显示了闪回数据库的当前状态,闪回数据库默认不启用

```sql
CONN / AS SYSDBA
SHUTDOWN IMMEDIATE
STARTUP MOUNT EXCLUSIVE
ALTER DATABASE FLASHBACK ON;
ALTER DATABASE OPEN;
```

* 如果数据库处于NOARCHIVELOG模式它必须切换到ARCHIVELOG模式。

```sql
CONN / AS SYSDBA
ALTER SYSTEM SET log_archive_dest_1='location=d:\oracle\oradata\DB10G\archive\'SCOPE=SPFILE;
ALTER SYSTEM SET log_archive_format='ARC%S_%R.%T' SCOPE=SPFILE;
SHUTDOWN IMMEDIATE
STARTUP MOUNT
ALTER DATABASE ARCHIVELOG;
ALTER DATABASE OPEN;
```

* 用启用闪回数据库以后，数据库可以切换回回过去的一个时间点或SCN，而不需要完全的手动恢复。(SCN是当Oracle数据库更新后，由DBMS自动维护去累积递增的一个数字)。

```sql
-- Create a dummy table.
CONN scott/tiger
CREATE TABLE flashback_database_test (
  id  NUMBER(10)
);

-- Flashback 5 minutes.
CONN / AS SYSDBA
SHUTDOWN IMMEDIATE
STARTUP MOUNT EXCLUSIVE
FLASHBACK DATABASE TO TIMESTAMP SYSDATE-(1/24/12);
ALTER DATABASE OPEN RESETLOGS;

-- Check that the table is gone.
CONN scott/tiger
DESC flashback_database_test
```

* 闪回数据库的一些其他形式命令包括：

```sql
FLASHBACK DATABASE TO TIMESTAMP my_date;
FLASHBACK DATABASE TO BEFORE TIMESTAMP my_date;
FLASHBACK DATABASE TO SCN my_scn;
FLASHBACK DATABASE TO BEFORE SCN my_scn;
```


## 闪回删除

* 在Oracle 10g中一个DROP TABLE命令的默认操作是将表到回收站（或重新命名它） 而不是真正的删除它。`DROP TABLE... PURGE`选项可用于永久删除表。

```sql
DROP TABLE my_table PURGE;
```

* 回收站是之前删除的对象的逻辑集合，与访问绑定在DROP特权上。此功能不使用闪回日志或撤消，因此它独立于其它闪回技术。回收站的内容可以使用SHOW RECYCLEBIN命令来显示和使用PURGE TABLE命令清除。以前删除的表可以从回收站中恢复。

```sql
CREATE TABLE flashback_drop_test (
  id  NUMBER(10)
);

INSERT INTO flashback_drop_test (id) VALUES (1);
COMMIT;

DROP TABLE flashback_drop_test;

SHOW RECYCLEBIN

ORIGINAL NAME    RECYCLEBIN NAME                OBJECT TYPE  DROP TIME
---------------- ------------------------------ ------------ -------------------
FLASHBACK_DROP_T BIN$TstgCMiwQA66fl5FFDTBgA==$0 TABLE        2004-03-29:11:09:07
EST

FLASHBACK TABLE flashback_drop_test TO BEFORE DROP;

SELECT * FROM flashback_drop_test;

        ID
----------
         1
```

* 在回收站中的表可以像任何其他表一样进行查询。

```sql
DROP TABLE flashback_drop_test;

SHOW RECYCLEBIN

ORIGINAL NAME    RECYCLEBIN NAME                OBJECT TYPE  DROP TIME
---------------- ------------------------------ ------------ -------------------
FLASHBACK_DROP_T BIN$TDGqmJZKR8u+Hrc6PGD8kw==$0 TABLE        2004-03-29:11:18:39
EST

SELECT * FROM "BIN$TDGqmJZKR8u+Hrc6PGD8kw==$0";

        ID
----------
         1
```

* 如果一个对象被多次删除并重新创建,那他的所有被删除的版本将被保留在回收站中，主体保留在空间。如果有多个版本存在，最好通过RECYCLEBIN_NAME引用表。用于向假定最新对象的ORIGINAL_NAME任何引用是删除的版本中所引用的问题。在闪回操作时的表可以重命名。

```sql
FLASHBACK TABLE flashback_drop_test TO BEFORE DROP RENAME TO flashback_drop_test_old;
```


## 闪回版本查询

>闪回版本查询允许使用BETWEEN子句在指定时间段内进行跟踪特定版本的行。

```sql
CREATE TABLE flashback_version_query_test (
  id           NUMBER(10),
  description  VARCHAR2(50)
);

INSERT INTO flashback_version_query_test (id, description) VALUES (1, 'ONE');
COMMIT;

SELECT current_scn, TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS') FROM v$database;

CURRENT_SCN TO_CHAR(SYSTIMESTAM
----------- -------------------
     725202 2004-03-29 14:59:08
     
UPDATE flashback_version_query_test SET description = 'TWO' WHERE id = 1;
COMMIT;
UPDATE flashback_version_query_test SET description = 'THREE' WHERE id = 1;
COMMIT;

SELECT current_scn, TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS') FROM v$database;

CURRENT_SCN TO_CHAR(SYSTIMESTAM
----------- -------------------
     725219 2004-03-29 14:59:36
     
COLUMN versions_startscn FORMAT 99999999999999999
COLUMN versions_starttime FORMAT A24
COLUMN versions_endscn FORMAT 99999999999999999
COLUMN versions_endtime FORMAT A24
COLUMN versions_xid FORMAT A16
COLUMN versions_operation FORMAT A1
COLUMN description FORMAT A11
SET LINESIZE 200

SELECT versions_startscn, versions_starttime, 
       versions_endscn, versions_endtime,
       versions_xid, versions_operation,
       description  
FROM   flashback_version_query_test 
       VERSIONS BETWEEN TIMESTAMP TO_TIMESTAMP('2004-03-29 14:59:08', 'YYYY-MM-DD HH24:MI:SS')
       AND TO_TIMESTAMP('2004-03-29 14:59:36', 'YYYY-MM-DD HH24:MI:SS')
WHERE  id = 1;

 VERSIONS_STARTSCN VERSIONS_STARTTIME          VERSIONS_ENDSCN VERSIONS_ENDTIME         VERSIONS_XID     V DESCRIPTION
------------------ ------------------------ ------------------ ------------------------ ---------------- - -----------
            725212 29-MAR-04 02.59.16 PM                                                02001C0043030000 U THREE
            725209 29-MAR-04 02.59.16 PM                725212 29-MAR-04 02.59.16 PM    0600030021000000 U TWO
                                                        725209 29-MAR-04 02.59.16 PM                       ONE

SELECT versions_startscn, versions_starttime, 
       versions_endscn, versions_endtime,
       versions_xid, versions_operation,
       description  
FROM   flashback_version_query_test 
       VERSIONS BETWEEN SCN 725202 AND 725219
WHERE  id = 1;

 VERSIONS_STARTSCN VERSIONS_STARTTIME          VERSIONS_ENDSCN VERSIONS_ENDTIME         VERSIONS_XID     V DESCRIPTION
------------------ ------------------------ ------------------ ------------------------ ---------------- - -----------
            725212 29-MAR-04 02.59.16 PM                                                02001C0043030000 U THREE
            725209 29-MAR-04 02.59.16 PM                725212 29-MAR-04 02.59.16 PM    0600030021000000 U TWO
                                                        725209 29-MAR-04 02.59.16 PM                       ONE
```

**可用参数含义为：**

* `VERSIONS_STARTSCN` or `VERSIONS_STARTTIME` - 起始SCN和时间戳
* `VERSIONS_ENDSCN` or `VERSIONS_ENDTIME` - 结束SCN和TIMESTAMP
* `VERSIONS_XID` - 在当前状态下创建的行的事务ID
* `VERSIONS_OPERATION` - 由事务执行的操作（（I）nsert，（U）PDATE或（D）elete）


## 闪回数据归档（FDA）
> * 使用CREATE FLASHBACK ARCHIVE语句创建一个闪回数据归档，它提供了对指定的数据库对象数据更改的自动跟踪和存档事务的能力。一个闪回归档数据由许多表空间和存储来自针对被跟踪的表事务的历史数据组成。

> * 使用RETENTION参数来声明闪回数据归档保留历史数据的时间周期。历史数据可以使用闪回查询AS子句进行查询。已超越保留期限的历史归档数据将被自动清除。

> * 在DDL不影响表结构的前提下，可以通过数据定义语言更改闪回数据归档保存的历史数据的数据库。一个例外是，当把新列添加到表时闪回数据归档将保留做历史数据。

* 创建一个新用户，并授予他必需的权限：

```sql
SQL> 
create
user usr 
identified by
usr;
User created.

SQL> 
grant
connect, resource, flashback archive administer to usr;
Grant succeeded.
SQL>
```


* 创建一个新的单独的表空间用于数据存档：

```sql
SQL> 
create
tablespace tbs_arch datafile 'c:\flashback_archive.dbf' size 10m;
Tablespace created.
SQL>
```

* 使用如下创建闪回归档命令在这个表空间中创建闪回存档：

```sql
SQL> 
create
flashback archive fl_arch
2 tablespace tbs_arch retention 1 year;
Flashback archive created.
SQL>
```

使用上面的命令，一个文件名为fl_arch的闪回归档创建完成并驻留在名为的tbs_arch表空间，持有一年信息。这意味着你可以使用任何闪回查询，其中包含关于分配给这个闪回存档表历史资料一年。

* 创建一个表，插入一行，并把它分配给了闪回存档：

```sql
SQL> 
create
table tbl_fl_archive (id number, name varchar2(20));
Table created.

SQL> 
insert into
tbl_fl_archive values(1,'Flashback Archive');
1 row created.

SQL> 
commit;
Commit complete.

SQL> 
select * from
tbl_fl_archive;

ID NAME
---------- --------------------
1 Flashback Archive

SQL> 
alter
table tbl_fl_archive flashback archive fl_archive;
Table altered.
SQL>
```

* 对tbl_fl_archive表的更改历史将被记入名为fl_archive的闪回存档；为了测试，删除表中的所有行和使用闪回queryon该表。它不会去找还原数据;它会寻找到改变的闪回存档文件：

```sql
SQL> 
select
to_char(sysdate,'ddmmyyyy hh24:mi:ss') ddate 
from
dual;

DDATE
-----------------
13022010 12:46:49

SQL> 
delete
from tbl_fl_archive;
1 row deleted.

SQL> 
commit;
Commit complete.

SQL> 
select * from
tbl_fl_archive;
no rows selected

SQL> 
select * from
tbl_fl_archive as of timestamp to_timestamp('13022010
12:46:49','ddmmyyyy hh24:mi:ss');

ID NAME
---------- --------------------
1 Flashback Archive

SQL>
```