SET SERVEROUTPUT ON
SPOOL ILAINST.LOG

drop user ilearn cascade;

prompt
prompt initialization database start.
prompt

create tablespace ilearn_data datafile '/home/oracle/app/db/oradata/cmccdb/ilearn_data1.dbf' size 2048M;

create tablespace ilearn_indx datafile '/home/oracle/app/db/oradata/cmccdb/ilearn_indx1.dbf' size 1024M;

create user ilearn identified by manager1 default tablespace ilearn_data temporary tablespace TEMP profile DEFAULT quota unlimited on ilearn_indx;

grant connect,resource,dba to ilearn;
grant unlimited tablespace to ilearn;

-- CONN ilearn/manager1@192.168.0.69:1525/cmccdb;

-- DEFINE IDX_TABLE_SPACE ='ilearn_indx';

-- @@./core/

prompt
prompt initialization database completed.
prompt

SPOOL OFF;
