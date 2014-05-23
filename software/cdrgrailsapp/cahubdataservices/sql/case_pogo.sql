select caseid, datecreated, bss, collectiontype, opotype, gender, age, race, ethnicity, bmi, mannerofdeath, causeofdeath, hardyscale, averagerin, averageautolysis, minfixtime, procedureduration 
  from case_pogo
-- Add/modify columns 
alter table CASE_POGO add date_created date;

update case_pogo set date_created = to_date(substr(datecreated, 1,10), 'YYYY-MM-DD')

/* overall */
select to_char(date_created,'MON-YYYY') as collection_month, (avg(cp.procedureduration)/(1000*60*60)) as procedure_duration
  from case_pogo cp
 group by to_char(date_created,'MON-YYYY')
 order by to_date(to_char(date_created,'MON-YYYY'),'MON-YYYY')

/* By BSS */
select to_char(date_created,'MON-YYYY') as collection_month, bss, (avg(cp.procedureduration)/(1000*60*60)) as procedure_duration
  from case_pogo cp
 group by to_char(date_created,'MON-YYYY'), bss
 order by to_date(to_char(date_created,'MON-YYYY'),'MON-YYYY'), bss


select to_date(to_char(date_created), 'MON-YYYY')),
       bss,
       avg(procedureduration) as avg_proc_duration
  from case_pogo
group by to_char(to_date(datecreated, 'MON-YYYY')),
       bss
order by to_char(to_date(datecreated, 'MON-YYYY')),
       bss
