select case_id, specimenid, datecreated, tissuetype, presumedflag, intdeathtoclamptime, intdeathtoprocstart, intdeathtochestincision, intheadputonice, intbrainremovalstart, 
       intbrainendaliquot, intdeathtoexcision, intdeathtofixative, ischemictime, collectiontype, bss, mannerofdeath, causeofdeath, venttime, averagerin, autolysis, 
       gender, age, bmi, race, ethnicity, opotype, hardyscale, minfixtime, procedureduration,
       ischemic_hhmm
  from specimen_pogo

select * from case_pogo

update specimen_pogo
   set case_id  = substr(specimenid, 1, 11)

alter table SPECIMEN_POGO add ischemic_hhmm number;
alter table SPECIMEN_POGO add date_created date;


update specimen_pogo
   set ischemic_hhmm  = (ischemictime / (1000 * 60 * 60))

  select avg(ischemictime) from specimen_pogo
  
  select count(*) from specimen_pogo

update specimen_pogo set date_created = to_date(substr(datecreated, 1,10), 'YYYY-MM-DD')
  
/* overall */
select to_char(date_created,'MON-YYYY') as collection_month, (avg(ischemictime)/(1000*60*60)) as ischemic_time
  from specimen_pogo sp
 group by to_char(date_created,'MON-YYYY')
 order by to_date(to_char(date_created,'MON-YYYY'),'MON-YYYY')
 
/* By BSS */
select to_char(date_created,'MON-YYYY') as collection_month, bss, (avg(ischemictime)/(1000*60*60)) as ischemic_time
  from specimen_pogo sp
 group by to_char(date_created,'MON-YYYY'), bss
 order by to_date(to_char(date_created,'MON-YYYY'),'MON-YYYY'), bss
