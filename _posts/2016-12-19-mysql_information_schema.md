---
layout: post
title: MySQL的INFORMATION_SCHEMA数据库
category: 数据库
---

### reference

[mysql information-schema](http://dev.mysql.com/doc/refman/5.7/en/information-schema.html)

### 基础查询语句

* 获取数据库名

```sql
show databases;
```

* 获取表名

```sql
show tables [from dbname];
```

* 获取表结构

```sql
desc tbname [filed]; / desc dbname.tbname[.field];
show columns from tbname [from dbname]; / show fields from tbname [from dbname];
show full columns from [dbname.]tbname;
```

* 获取建表语句

```sql
show create table [dbname.]tbname;
```

### INFORMATION_SCHEMA

> `INFORMATION_SCHEMA` provides access to database metadata, information about the MySQL server such as the name of a database or table, the data type of a column, or access privileges. Other terms that are sometimes used for this information are data dictionary and system catalog.

> `INFORMATION_SCHEMA` is a database within each MySQL instance, the place that stores information about all the other databases that the MySQL server maintains. The `INFORMATION_SCHEMA` database contains several read-only tables. They are actually views, not base tables, so there are no files associated with them, and you cannot set triggers on them. Also, there is no database directory with that name.
Although you can select INFORMATION_SCHEMA as the default database with a USE statement, you can only read the contents of tables, not perform `INSERT`, `UPDATE`, or `DELETE` operations on them.

#### INFORMATION_SCHEMA中的表

```sql
+---------------------------------------+
| Tables_in_information_schema          |
+---------------------------------------+
| CHARACTER_SETS                        |
| COLLATIONS                            |
| COLLATION_CHARACTER_SET_APPLICABILITY |
| COLUMNS                               |*
| COLUMN_PRIVILEGES                     |*
| ENGINES                               |
| EVENTS                                |
| FILES                                 |
| GLOBAL_STATUS                         |
| GLOBAL_VARIABLES                      |
| KEY_COLUMN_USAGE                      |
| OPTIMIZER_TRACE                       |
| PARAMETERS                            |
| PARTITIONS                            |
| PLUGINS                               |
| PROCESSLIST                           |
| PROFILING                             |
| REFERENTIAL_CONSTRAINTS               |
| ROUTINES                              |
| SCHEMATA                              |*
| SCHEMA_PRIVILEGES                     |
| SESSION_STATUS                        |
| SESSION_VARIABLES                     |
| STATISTICS                            |
| TABLES                                |*
| TABLESPACES                           |
| TABLE_CONSTRAINTS                     |
| TABLE_PRIVILEGES                      |
| TRIGGERS                              |
| USER_PRIVILEGES                       |
| VIEWS                                 |
| INNODB_LOCKS                          |
| INNODB_TRX                            |
| INNODB_SYS_DATAFILES                  |
| INNODB_FT_CONFIG                      |
| INNODB_SYS_VIRTUAL                    |
| INNODB_CMP                            |
| INNODB_FT_BEING_DELETED               |
| INNODB_CMP_RESET                      |
| INNODB_CMP_PER_INDEX                  |
| INNODB_CMPMEM_RESET                   |
| INNODB_FT_DELETED                     |
| INNODB_BUFFER_PAGE_LRU                |
| INNODB_LOCK_WAITS                     |
| INNODB_TEMP_TABLE_INFO                |
| INNODB_SYS_INDEXES                    |
| INNODB_SYS_TABLES                     |
| INNODB_SYS_FIELDS                     |
| INNODB_CMP_PER_INDEX_RESET            |
| INNODB_BUFFER_PAGE                    |
| INNODB_FT_DEFAULT_STOPWORD            |
| INNODB_FT_INDEX_TABLE                 |
| INNODB_FT_INDEX_CACHE                 |
| INNODB_SYS_TABLESPACES                |
| INNODB_METRICS                        |
| INNODB_SYS_FOREIGN_COLS               |
| INNODB_CMPMEM                         |
| INNODB_BUFFER_POOL_STATS              |
| INNODB_SYS_COLUMNS                    |
| INNODB_SYS_FOREIGN                    |
| INNODB_SYS_TABLESTATS                 |
+---------------------------------------+
```

#### COLUMNS表

> The `COLUMNS` table provides information about columns in tables.

##### 表字段

```sql
+--------------------------+---------------------+-----------------+------+-----+---------+-------+------------+---------+
| Field                    | Type                | Collation       | Null | Key | Default | Extra | Privileges | Comment |
+--------------------------+---------------------+-----------------+------+-----+---------+-------+------------+---------+
| TABLE_CATALOG            | varchar(512)        | utf8_general_ci | NO   |     |         |       | select     |         |
| TABLE_SCHEMA             | varchar(64)         | utf8_general_ci | NO   |     |         |       | select     |         |
| TABLE_NAME               | varchar(64)         | utf8_general_ci | NO   |     |         |       | select     |         |
| COLUMN_NAME              | varchar(64)         | utf8_general_ci | NO   |     |         |       | select     |         |
| ORDINAL_POSITION         | bigint(21) unsigned | NULL            | NO   |     | 0       |       | select     |         |
| COLUMN_DEFAULT           | longtext            | utf8_general_ci | YES  |     | NULL    |       | select     |         |
| IS_NULLABLE              | varchar(3)          | utf8_general_ci | NO   |     |         |       | select     |         |
| DATA_TYPE                | varchar(64)         | utf8_general_ci | NO   |     |         |       | select     |         |
| CHARACTER_MAXIMUM_LENGTH | bigint(21) unsigned | NULL            | YES  |     | NULL    |       | select     |         |
| CHARACTER_OCTET_LENGTH   | bigint(21) unsigned | NULL            | YES  |     | NULL    |       | select     |         |
| NUMERIC_PRECISION        | bigint(21) unsigned | NULL            | YES  |     | NULL    |       | select     |         |
| NUMERIC_SCALE            | bigint(21) unsigned | NULL            | YES  |     | NULL    |       | select     |         |
| DATETIME_PRECISION       | bigint(21) unsigned | NULL            | YES  |     | NULL    |       | select     |         |
| CHARACTER_SET_NAME       | varchar(32)         | utf8_general_ci | YES  |     | NULL    |       | select     |         |
| COLLATION_NAME           | varchar(32)         | utf8_general_ci | YES  |     | NULL    |       | select     |         |
| COLUMN_TYPE              | longtext            | utf8_general_ci | NO   |     | NULL    |       | select     |         |
| COLUMN_KEY               | varchar(3)          | utf8_general_ci | NO   |     |         |       | select     |         |
| EXTRA                    | varchar(30)         | utf8_general_ci | NO   |     |         |       | select     |         |
| PRIVILEGES               | varchar(80)         | utf8_general_ci | NO   |     |         |       | select     |         |
| COLUMN_COMMENT           | varchar(1024)       | utf8_general_ci | NO   |     |         |       | select     |         |
| GENERATION_EXPRESSION    | longtext            | utf8_general_ci | NO   |     | NULL    |       | select     |         |
+--------------------------+---------------------+-----------------+------+-----+---------+-------+------------+---------+
```

##### 查询某张表字段的几个常见信息

```sql
select table_schema,`TABLE_NAME`,`COLUMN_NAME`,`ORDINAL_POSITION`,`COLUMN_DEFAULT`,`IS_NULLABLE`,`DATA_TYPE`,`COLUMN_TYPE`,`COLUMN_KEY`,`COLUMN_COMMENT`
from information_schema.columns 
where table_schema='test' AND table_name='family';
```

```sql
+--------------+------------+------------------+------------------+----------------+-------------+-----------+--------------+------------+-----------------------------------+
| table_schema | TABLE_NAME | COLUMN_NAME      | ORDINAL_POSITION | COLUMN_DEFAULT | IS_NULLABLE | DATA_TYPE | COLUMN_TYPE  | COLUMN_KEY | COLUMN_COMMENT                    |
+--------------+------------+------------------+------------------+----------------+-------------+-----------+--------------+------------+-----------------------------------+
| test         | family     | id               |                1 | NULL           | NO          | bigint    | bigint(20)   | PRI        | 主键ID                            |
| test         | family     | size             |                2 | NULL           | YES         | smallint  | smallint(6)  |            | 家庭人数                          |
| test         | family     | kid_size         |                3 | NULL           | YES         | smallint  | smallint(6)  |            | 小孩数                            |
| test         | family     | income           |                4 | NULL           | YES         | tinyint   | tinyint(4)   |            | 月收入－区间枚举值                |
| test         | family     | address          |                5 | NULL           | NO          | varchar   | varchar(256) |            | 家庭地址                          |
| test         | family     | telephone        |                6 | NULL           | YES         | varchar   | varchar(16)  |            | 家庭电话                          |
| test         | family     | postcode         |                7 | NULL           | YES         | varchar   | varchar(6)   |            | 居住地邮编                        |
| test         | family     | province_id      |                8 | NULL           | YES         | bigint    | bigint(20)   |            | 家庭地址－省                      |
| test         | family     | province_name    |                9 | NULL           | YES         | varchar   | varchar(32)  |            | 省名称                            |
| test         | family     | city_id          |               10 | NULL           | YES         | bigint    | bigint(20)   |            | 家庭地址－市                      |
| test         | family     | city_name        |               11 | NULL           | YES         | varchar   | varchar(32)  |            | 市名称                            |
| test         | family     | district_id      |               12 | NULL           | YES         | bigint    | bigint(20)   |            | 家庭地址－区                      |
| test         | family     | district_name    |               13 | NULL           | YES         | varchar   | varchar(32)  |            | 区名称                            |
| test         | family     | subdistrict_id   |               14 | NULL           | YES         | bigint    | bigint(20)   |            | 家庭地址－街道                    |
| test         | family     | subdistrict_name |               15 | NULL           | YES         | varchar   | varchar(64)  |            | 街道名称                          |
| test         | family     | addr_detail      |               16 | NULL           | YES         | varchar   | varchar(128) |            | 家庭地址－详细地址部分            |
| test         | family     | is_deleted       |               17 | NULL           | YES         | tinyint   | tinyint(1)   |            | 删除标志 -1:删除 0:正常           |
| test         | family     | created_at       |               18 | NULL           | YES         | datetime  | datetime     |            | 创建时间                          |
| test         | family     | updated_at       |               19 | NULL           | YES         | datetime  | datetime     |            | 更新时间                          |
+--------------+------------+------------------+------------------+----------------+-------------+-----------+--------------+------------+-----------------------------------+
```

##### `COLUMNS`表查询的等价语句

```sql
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_DEFAULT
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE table_name = 'tbl_name'
  [AND table_schema = 'db_name']
  [AND column_name LIKE 'wild']

SHOW COLUMNS
  FROM tbl_name
  [FROM db_name]
  [LIKE 'wild']

```

#### COLUMN_PRIVILEGES表

> The `COLUMN_PRIVILEGES` table provides information about column privileges. This information comes from the `mysql.columns_priv` grant table.

##### COLUMN_PRIVILEGES表字段

```sql
+----------------+--------------+-----------------+------+-----+---------+-------+------------+---------+
| Field          | Type         | Collation       | Null | Key | Default | Extra | Privileges | Comment |
+----------------+--------------+-----------------+------+-----+---------+-------+------------+---------+
| GRANTEE        | varchar(81)  | utf8_general_ci | NO   |     |         |       | select     |         |
| TABLE_CATALOG  | varchar(512) | utf8_general_ci | NO   |     |         |       | select     |         |
| TABLE_SCHEMA   | varchar(64)  | utf8_general_ci | NO   |     |         |       | select     |         |
| TABLE_NAME     | varchar(64)  | utf8_general_ci | NO   |     |         |       | select     |         |
| COLUMN_NAME    | varchar(64)  | utf8_general_ci | NO   |     |         |       | select     |         |
| PRIVILEGE_TYPE | varchar(64)  | utf8_general_ci | NO   |     |         |       | select     |         |
| IS_GRANTABLE   | varchar(3)   | utf8_general_ci | NO   |     |         |       | select     |         |
+----------------+--------------+-----------------+------+-----+---------+-------+------------+---------+
```

##### 说明
* In the output from `SHOW FULL COLUMNS`, the privileges are all in one field and in *lowercase*, for example, select,insert,update,references. In COLUMN_PRIVILEGES, there is one privilege per row, in *uppercase*.

* `PRIVILEGE_TYPE` can contain one (and only one) of these values: SELECT, INSERT, UPDATE, REFERENCES.

* If the user has GRANT OPTION privilege, IS_GRANTABLE should be YES. Otherwise, IS_GRANTABLE should be NO. The output does not list GRANT OPTION as a separate privilege.

##### 查看字段权限

```sql
mysql> select * from information_schema.column_privileges where table_schema='test' AND table_name='family';
Empty set (0.00 sec)
```

```sql
Empty set
```

创建用户并授权

```sql
create user guest@localhost identified by '123';
grant select (`address`,`telephone`) on test.family to 'guest'@'localhost';
flush privileges;
```

```sql
mysql> select * from information_schema.column_privileges where table_schema='test' AND table_name='family';
+---------------------+---------------+--------------+------------+-------------+----------------+--------------+
| GRANTEE             | TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | COLUMN_NAME | PRIVILEGE_TYPE | IS_GRANTABLE |
+---------------------+---------------+--------------+------------+-------------+----------------+--------------+
| 'guest'@'localhost' | def           | test         | family     | telephone   | SELECT         | NO           |
| 'guest'@'localhost' | def           | test         | family     | address     | SELECT         | NO           |
+---------------------+---------------+--------------+------------+-------------+----------------+--------------+
```

##### `COLUMN_PRIVILEGES`表查询的等价语句

```sql
SELECT ... FROM INFORMATION_SCHEMA.COLUMN_PRIVILEGES

SHOW GRANTS ...
```

```sql
mysql> show grants for guest@localhost;
+-----------------------------------------------------------------------------+
| Grants for guest@localhost                                                  |
+-----------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'guest'@'localhost'                                   |
| GRANT SELECT ON `test`.* TO 'guest'@'localhost'                             |
| GRANT SELECT (telephone, address) ON `test`.`family` TO 'guest'@'localhost' |
+-----------------------------------------------------------------------------+
```

#### SCHEMATA表

> A schema is a database, so the `SCHEMATA` table provides information about databases.

##### 表字段

```sql
mysql> show full columns from information_schema.schemata;
+----------------------------+--------------+-----------------+------+-----+---------+-------+------------+---------+
| Field                      | Type         | Collation       | Null | Key | Default | Extra | Privileges | Comment |
+----------------------------+--------------+-----------------+------+-----+---------+-------+------------+---------+
| CATALOG_NAME               | varchar(512) | utf8_general_ci | NO   |     |         |       | select     |         |
| SCHEMA_NAME                | varchar(64)  | utf8_general_ci | NO   |     |         |       | select     |         |
| DEFAULT_CHARACTER_SET_NAME | varchar(32)  | utf8_general_ci | NO   |     |         |       | select     |         |
| DEFAULT_COLLATION_NAME     | varchar(32)  | utf8_general_ci | NO   |     |         |       | select     |         |
| SQL_PATH                   | varchar(512) | utf8_general_ci | YES  |     | NULL    |       | select     |         |
+----------------------------+--------------+-----------------+------+-----+---------+-------+------------+---------+
```

##### 查询数据库

```
mysql> select * from information_schema.schemata where schema_name like 'test';
+--------------+-------------+----------------------------+------------------------+----------+
| CATALOG_NAME | SCHEMA_NAME | DEFAULT_CHARACTER_SET_NAME | DEFAULT_COLLATION_NAME | SQL_PATH |
+--------------+-------------+----------------------------+------------------------+----------+
| def          | test        | utf8                       | utf8_general_ci        | NULL     |
+--------------+-------------+----------------------------+------------------------+----------+
```

```sql
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| test               |
+--------------------+
```

##### SCHEMATA表查询的等价语句

```sql
SELECT SCHEMA_NAME AS `Database`
  FROM INFORMATION_SCHEMA.SCHEMATA
  [WHERE SCHEMA_NAME LIKE 'wild']

SHOW DATABASES
  [LIKE 'wild']
```

#### TABLES表

> The TABLES table provides information about tables in databases.

##### TABLES表字段

```sql
mysql> show full columns from information_schema.tables;
+-----------------+---------------------+-----------------+------+-----+---------+-------+------------+---------+
| Field           | Type                | Collation       | Null | Key | Default | Extra | Privileges | Comment |
+-----------------+---------------------+-----------------+------+-----+---------+-------+------------+---------+
| TABLE_CATALOG   | varchar(512)        | utf8_general_ci | NO   |     |         |       | select     |         |
| TABLE_SCHEMA    | varchar(64)         | utf8_general_ci | NO   |     |         |       | select     |         |
| TABLE_NAME      | varchar(64)         | utf8_general_ci | NO   |     |         |       | select     |         |
| TABLE_TYPE      | varchar(64)         | utf8_general_ci | NO   |     |         |       | select     |         |
| ENGINE          | varchar(64)         | utf8_general_ci | YES  |     | NULL    |       | select     |         |
| VERSION         | bigint(21) unsigned | NULL            | YES  |     | NULL    |       | select     |         |
| ROW_FORMAT      | varchar(10)         | utf8_general_ci | YES  |     | NULL    |       | select     |         |
| TABLE_ROWS      | bigint(21) unsigned | NULL            | YES  |     | NULL    |       | select     |         |
| AVG_ROW_LENGTH  | bigint(21) unsigned | NULL            | YES  |     | NULL    |       | select     |         |
| DATA_LENGTH     | bigint(21) unsigned | NULL            | YES  |     | NULL    |       | select     |         |
| MAX_DATA_LENGTH | bigint(21) unsigned | NULL            | YES  |     | NULL    |       | select     |         |
| INDEX_LENGTH    | bigint(21) unsigned | NULL            | YES  |     | NULL    |       | select     |         |
| DATA_FREE       | bigint(21) unsigned | NULL            | YES  |     | NULL    |       | select     |         |
| AUTO_INCREMENT  | bigint(21) unsigned | NULL            | YES  |     | NULL    |       | select     |         |
| CREATE_TIME     | datetime            | NULL            | YES  |     | NULL    |       | select     |         |
| UPDATE_TIME     | datetime            | NULL            | YES  |     | NULL    |       | select     |         |
| CHECK_TIME      | datetime            | NULL            | YES  |     | NULL    |       | select     |         |
| TABLE_COLLATION | varchar(32)         | utf8_general_ci | YES  |     | NULL    |       | select     |         |
| CHECKSUM        | bigint(21) unsigned | NULL            | YES  |     | NULL    |       | select     |         |
| CREATE_OPTIONS  | varchar(255)        | utf8_general_ci | YES  |     | NULL    |       | select     |         |
| TABLE_COMMENT   | varchar(2048)       | utf8_general_ci | NO   |     |         |       | select     |         |
+-----------------+---------------------+-----------------+------+-----+---------+-------+------------+---------+
```



