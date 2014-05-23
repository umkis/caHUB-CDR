-- COL constraint_source FORMAT A38 HEADING "Constraint Name:| Table.Column"
-- COL references_column FORMAT A38 HEADING "References:| Table.Column"
 
SELECT   uc.constraint_name||CHR(10)
||      '('||ucc1.TABLE_NAME||'.'||ucc1.column_name||')' constraint_source
,       'REFERENCES'||CHR(10)
||      '('||ucc2.TABLE_NAME||'.'||ucc2.column_name||')' references_column
FROM     user_constraints uc
,        user_cons_columns ucc1
,        user_cons_columns ucc2
WHERE    uc.constraint_name = ucc1.constraint_name
AND      uc.r_constraint_name = ucc2.constraint_name
AND      ucc1.POSITION = ucc2.POSITION -- Correction for multiple column primary keys.
AND      uc.constraint_type = 'R'
 and instr(uc.constraint_name, 'FK2815B20830C22E2D') != 0 
/* and instr(ucc2.table_name, 'BPV_TISSUE_FORM') != 0 */
ORDER BY ucc1.TABLE_NAME
,        uc.constraint_name;

SELECT   uc.constraint_name||CHR(10)
||      '('||ucc1.TABLE_NAME||'.'||ucc1.column_name||')' constraint_source
,       'REFERENCES'||CHR(10)
||      '('||ucc2.TABLE_NAME||'.'||ucc2.column_name||')' references_column
FROM     user_constraints uc
,        user_cons_columns ucc1
,        user_cons_columns ucc2
WHERE    uc.constraint_name = ucc1.constraint_name
AND      uc.r_constraint_name = ucc2.constraint_name
AND      ucc1.POSITION = ucc2.POSITION -- Correction for multiple column primary keys.
AND      uc.constraint_type = 'R'
/* and instr(ucc1.column_name, 'STUDY_ID') != 0 */
and instr(ucc2.table_name, 'BPV_BLOOD_FORM') != 0
ORDER BY ucc1.TABLE_NAME
,        uc.constraint_name;

alter table bpv_therapy drop constraint FKAF48B1B8D69D70E2 cascade;


SELECT uc.constraint_name, ucc1.table_name, ucc1.column_name 
  from user_constraints uc, 
       user_cons_columns ucc1
WHERE  uc.constraint_name = ucc1.constraint_name
and    uc.constraint_name like '%C0052270%'

SELECT uc.constraint_name, ucc1.table_name, ucc1.column_name, uc.constraint_type
  from user_constraints uc, 
       user_cons_columns ucc1
WHERE  uc.constraint_name = ucc1.constraint_name
and    uc.table_name = upper('ST_MONTHLY_GOAL')

select distinct constraint_type from user_constraints

select * from user_cons_columns

select * from user_CONSTRAINTS

SELECT * FROM DR_SHIPEVT where case_id like '%BRN%'

SELECT * FROM DR_SHIPEVT order by id
SELECT * FROM DR_specimen order by id

select max(id) from dr_shipevt


SELECT * FROM DR_SHIPEVT where bio4d_event_id like '%Open%'

select * from dr_slide

select * from dba_directories;

CREATE DIRECTORY df1 AS 'c:\temp';
GRANT READ, WRITE ON DIRECTORY df1 TO cdrds;
CREATE DIRECTORY dl1 AS 'c:\var';
GRANT READ, WRITE ON DIRECTORY dl1 TO cdrds;
