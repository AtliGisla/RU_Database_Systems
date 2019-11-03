Create table temp_timing( type varchar(10), time timestamp );
insert into temp_timing values( 'START', localtimestamp );
\set AUTOCOMMIT OFF
BEGIN;
\o /dev/null
\i 'scale_db_fill.sql';
\o
COMMIT;
\set AUTOCOMMIT ON
insert into temp_timing values( 'STOP', localtimestamp );
select age( (select time from temp_timing where type = 'STOP'), (select time from temp_timing where type = 'START' ) );
drop table temp_timing;
