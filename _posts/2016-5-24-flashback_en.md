﻿---
layout: post
title: Oracle Flashback Technology EN
category: 数据库
---

# Oracle Flashback Technology(EN)

## Overview

> Oracle Flashback Technology is a group of Oracle Database features that let you view past states of database objects or to return database objects to a previous state without using point-in-time media recovery.

**With flashback features, you can do the following:**

* Perform queries that return past data
* Perform queries that return metadata that shows a detailed history of changes to the database
* Recover tables or rows to a previous point in time
* Automatically track and archive transactional data changes
* Roll back a transaction and its dependent transactions while the database remains online

**Flashback Technology gives you 6 different ways to track and fix logical corruption(逻辑错误) through different approach.**

* Oracle Flashback Query feature lets you specify a target time and then run queries against your database, viewing results as they would have appeared at that time.
* Oracle Flashback Version Query lets you view all the versions of all the rows that ever existed in one or more tables in a specified time interval.
* Oracle Flashback Transaction Query lets you view changes made by a single transaction, or by all the transactions during a period of time.
* Oracle Flashback Table returns a table to its state at a previous point in time.
* Oracle Flashback Drop reverses the effects of a DROP TABLE statement. 
* Oracle Flashback Database provides a more efficient alternative to database point-in-time recovery.



## Flashback Database

* have SYSDBA privilege 
* flash recovery area must have been prepared in advance

```sql
show parameter db_recovery_file;
```

* The FLASHBACK_ON column of the V$DATABASE view shows the current status of flashback database,Flashback database is not enabled by default

```
CONN / AS SYSDBA
SHUTDOWN IMMEDIATE
STARTUP MOUNT EXCLUSIVE
ALTER DATABASE FLASHBACK ON;
ALTER DATABASE OPEN;
```

* If the database is in NOARCHIVELOG it must be switched to ARCHIVELOG mode.

```sql
CONN / AS SYSDBA
ALTER SYSTEM SET log_archive_dest_1='location=d:\oracle\oradata\DB10G\archive\'SCOPE=SPFILE;
ALTER SYSTEM SET log_archive_format='ARC%S_%R.%T' SCOPE=SPFILE;
SHUTDOWN IMMEDIATE
STARTUP MOUNT
ALTER DATABASE ARCHIVELOG;
ALTER DATABASE OPEN;
```

* With flashback enabled the database can be switched back to a previous point in time or SCN without the need for a manual incomplete recovery.

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

* Some other variations of the flashback database command include.

```sql
FLASHBACK DATABASE TO TIMESTAMP my_date;
FLASHBACK DATABASE TO BEFORE TIMESTAMP my_date;
FLASHBACK DATABASE TO SCN my_scn;
FLASHBACK DATABASE TO BEFORE SCN my_scn;
```


## Flashback Drop

* In Oracle 10g the default action of a DROP TABLE command is to move the table to the recycle bin(回收站) (or rename it), rather than actually dropping it. The `DROP TABLE ... PURGE` option can be used to permanently(完全) drop a table.

```sql
DROP TABLE my_table PURGE;
```

* The recycle bin is a logical collection of previously dropped objects, with access tied to the DROP privilege. This feature does not use flashback logs or undo, so it is independent of the other flashback technologies. The contents of the recycle bin can be shown using the SHOW RECYCLEBIN command and purged using the PURGE TABLE command. As a result, a previously dropped table can be recovered from the recycle bin.

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

* Tables in the recycle bin can be queried like any other table.

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

* If an object is dropped and recreated multiple times all dropped versions will be kept in the recycle bin, subject to space. Where multiple versions are present it's best to reference the tables via the RECYCLEBIN_NAME. For any references to the ORIGINAL_NAME it is assumed the most recent object is drop version in the referenced question. During the flashback operation the table can be renamed.

```sql
FLASHBACK TABLE flashback_drop_test TO BEFORE DROP RENAME TO flashback_drop_test_old;
```


## Flashback Version Query
>Flashback version query allows the versions of a specific row to be tracked during a specified time period using the VERSIONS BETWEEN clause.

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

**The available pseudocolumn meanings are:**

* `VERSIONS_STARTSCN` or `VERSIONS_STARTTIME` - Starting SCN and TIMESTAMP when row took on this value. The value of NULL is returned if the row was created before the lower bound SCN or TIMESTAMP.
* `VERSIONS_ENDSCN` or `VERSIONS_ENDTIME` - Ending SCN and TIMESTAMP when row last contained this value. The value of NULL is returned if the value of the row is still current at the upper bound SCN or TIMESTAMP.
* `VERSIONS_XID` - ID of the transaction that created the row in it's current state.
* `VERSIONS_OPERATION` - Operation performed by the transaction ((I)nsert, (U)pdate or (D)elete)


## Flashback Data Archive (FDA)
> * Use the CREATE FLASHBACK ARCHIVE statement to create a flashback data archive, which provides the ability to automatically track and archive transactional data changes to specified database objects. A flashback data archive consists of multiple tablespaces and stores historic data from all transactions against tracked tables.

> * Flashback data archives retain historical data for the time duration specified using the RETENTION parameter. Historical data can be queried using the Flashback Query AS OF clause. Archived historic data that has aged beyond the specified retention period is automatically purged.

> * Flashback data archives retain historical data across data definition language (DDL) changes to the database as long as the DDL change does not affect the structure of the table. The one exception to this rule is that flashback data archives do retain historical data when a column is added to the table.

* Create a new user and grant him the required privileges:

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


* Create a new separate tablespace for data archive:

SQL> 
create
tablespace tbs_arch datafile 'c:\flashback_archive.dbf' size 10m;
Tablespace created.
SQL>

* Create flashback archive on this tablespace using the create flashback archive commandas follows:

```sql
SQL> 
create
flashback archive fl_arch
2 tablespace tbs_arch retention 1 year;
Flashback archive created.
SQL>
```

With the above command, a flashback archive named fl_arch is created which resides in the tablespace tbs_arch and holds information for one year. It means that you can use any flashback query which contains one year of historical information regarding the table that is assigned to this flashback archive.

* Now, create a table, insert one row and assign it to the flashback archive:

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

* The historical change on the table tbl_fl_archive will now be written to the flashback archive named fl_archive. To test it, delete all rows from the table and use flashback queryon that table. Remember, it will not look for the undo data; it will look to the flashback archive file for the changes:

```sql
SQL> 
select
to_char(sysdate,'ddmmyyyy hh24:mi:ss') ddate 
from
dual;

DDATE
-----------------
13022010 12:46:49

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