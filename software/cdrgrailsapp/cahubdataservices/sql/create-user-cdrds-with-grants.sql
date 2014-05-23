drop user cdrds cascade ;
create role read_role;
create role ro;

-- Create the user 
create user cdrds
  identified by admin
  default tablespace USERS
  temporary tablespace TEMP
  profile DEFAULT;
grant connect to cdrds;
grant create any table to cdrds ;
grant create any index to cdrds;
grant create any sequence to cdrds;
grant resource to cdrds;
grant create table to cdrds;
/* select * from cdrds.book; */
