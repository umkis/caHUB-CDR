
select avg (ischemictime)
  from
    (
    select distinct substr(specimenId,1,14) as tissue_id, ischemichhmm, ischemictime, 
       (to_char(round(ischemictime/(1000*60*60*24),0))||':'||to_char(round(mod(ischemictime/(1000*60*60*24),1)*24,0))) as dd_hh, 
       round(mod(ischemictime/(1000*60*60*24),1)*24,0) as hh,
       mod(ischemictime/(1000*60*60*24),1)*24 as hh_dec,
       (mod( mod(ischemictime/(1000*60*60*24),1)*24, round(mod(ischemictime/(1000*60*60*24),1)*24,0)) * 60) as mm
      from specimen_pogo
     order by ischemichhmm desc
     )

select avg(procedureduration)
  from 
    (
    select distinct caseId, sp.procedureduration 
      from specimen_pogo sp
    )

select * from specimen_pogo


select bss, avg (ischemictime)
  from
    (
    select distinct sp.bss, substr(specimenId,1,14) as tissue_id, ischemichhmm, ischemictime, 
       (to_char(round(ischemictime/(1000*60*60*24),0))||':'||to_char(round(mod(ischemictime/(1000*60*60*24),1)*24,0))) as dd_hh, 
       round(mod(ischemictime/(1000*60*60*24),1)*24,0) as hh,
       mod(ischemictime/(1000*60*60*24),1)*24 as hh_dec,
       (mod( mod(ischemictime/(1000*60*60*24),1)*24, round(mod(ischemictime/(1000*60*60*24),1)*24,0)) * 60) as mm
      from specimen_pogo sp
     where phase = 'Scale Up Phase 1'
     order by ischemichhmm desc
     )
 group by bss
 
select bss, avg(procedureduration)
  from 
    (
    select distinct sp.bss, caseId, sp.procedureduration 
      from specimen_pogo sp
    )
 group by bss
 
 
select distinct sp.bss, sp.phase
  from specimen_pogo sp
 order by sp.bss

select bss.code, bss.name, phase.name as phase, status.id, status.name as status, count(*)
  from dr_case        c,
       st_studyphase  phase,
       st_bss         bss,
       st_case_status status
 where c.phase_id = phase.id  and
       c.bss_id  = bss.id     and
       c.case_status_id = status.id 
 group by bss.code, bss.name, phase.name, status.id, status.name
 order by bss.code
 
select bss, avg (ischemictime)
  from
    (
    select distinct sp.bss, substr(specimenId,1,14) as tissue_id, ischemichhmm, ischemictime
      from specimen_pogo sp
     where phase = 'Scale Up Phase 1'
     order by ischemichhmm desc
     )
 group by bss


select bss, count(distinct caseId) from specimen_pogo
  where phase = 'Scale Up Phase 1'
 group by bss

select count(distinct substr(specimenId,1,14)) from specimen_pogo
  where phase = 'Scale Up Phase 1'
  
select bss, avg(procedureduration)
  from 
    (
    select distinct bss, caseId, sp.procedureduration 
      from specimen_pogo sp
     where phase = 'Scale Up Phase 1'
    )
 group by bss
 
update dr_case c set c.case_status_id = 7 where c.case_status_id in (21, 4) and c.phase_id = (select id from st_studyphase phase where phase.name = 'Scale Up Phase 1')
commit;

select count(*) from dr_case c where c.case_status_id in (21, 4) and c.phase_id in (select id from st_studyphase phase where phase.name = 'Scale Up Phase 1')

create table specimen_pogo_backup as (select * from specimen_pogo)

drop table specimen_pogo cascade constraints

drop sequence specimen_pogo_seq 

select avg (sp.ischemictime)
  from specimen_pogo sp
 where caseid in 
    (
    select distinct sp.caseid
      from specimen_pogo sp
     where sp.caseid not in 
           (
           select distinct sp.caseid
             from specimen_pogo sp
            where phase = 'Scale Up Phase 1' and
                  substr(sp.tissuetype,1,5) = 'Brain'
            )     
    )

select avg (sp.procedureduration)
  from specimen_pogo sp
 where caseid in 
    (
    select distinct sp.caseid
      from specimen_pogo sp
     where sp.caseid not in 
           (
           select distinct sp.caseid
             from specimen_pogo sp
            where phase = 'Scale Up Phase 1' and
                  substr(sp.tissuetype,1,5) = 'Brain'
            )     
    )


select avg (sp.ischemictime)
  from specimen_pogo sp
 where caseid in 
    (
    select distinct sp.caseid
      from specimen_pogo sp
     where phase = 'Scale Up Phase 1' and
           substr(sp.tissuetype,1,5) = 'Brain'
    )

select avg (sp.procedureduration)
  from specimen_pogo sp
 where caseid in 
    (
    select distinct sp.caseid
      from specimen_pogo sp
     where phase = 'Scale Up Phase 1' and
           substr(sp.tissuetype,1,5) = 'Brain'
    )

 
select collectiontype, avg(ischemictime), count (*) as frequency
  from
    (
    select distinct collectiontype, sp.tissuetype, sp.ischemictime
      from specimen_pogo sp
     where sp.phase in ('Scale Up Phase 1')
    )
 group by collectiontype

select collectiontype, avg(procedureduration), count (*) as frequency
  from
    (
    select distinct collectiontype, sp.caseId, sp.procedureduration
      from specimen_pogo sp
     where sp.phase in ('Scale Up Phase 1')
    )
 group by collectiontype
 
select collectiontype, avg(min_ischemic), avg(avg_ischemic), avg(max_ischemic), avg(latestrin), count (*) as frequency
  from
    (
    select collectiontype, caseId, min(sp.ischemictime) as min_ischemic, avg(sp.ischemictime) as avg_ischemic, max(sp.ischemictime) as max_ischemic, avg(sp.latestrin) as latestRin
      from specimen_pogo sp
     where sp.phase in ('Scale Up Phase 1') 
     group by collectiontype, caseId
    )
 group by collectiontype

select collectiontype, avg(min_ischemic), avg(avg_ischemic), avg(max_ischemic), avg(latestrin), count (*) as frequency
  from
    (
    select collectiontype, caseId, min(sp.ischemictime) as min_ischemic, avg(sp.ischemictime) as avg_ischemic, max(sp.ischemictime) as max_ischemic, avg(sp.latestrin) as latestRin
      from specimen_pogo sp
     where sp.phase in ('Interim Phase', 'Beta Phase', 'Pilot Phase') 
     group by collectiontype, caseId
    )
 group by collectiontype

select tissuetype, phase, fix.name as fixative, count(*)
  from specimen_pogo   sp,
       dr_specimen     spec,
       st_fixative     fix
 where /* ischemictime <= 0   and */
       spec.specimen_id = sp.specimenid and
       spec.fixative_id = fix.id
 group by tissuetype, phase, fix.name
 order by phase, tissuetype, fix.name
 
select * from specimen_pogo sp where substr(sp.tissuetype,1,5) = 'Blood'

select count(distinct caseid) from specimen_pogo sp where sp.latestrin is not null

select phase, count(*)
  from specimen_pogo   sp,
       dr_specimen     spec,
       st_fixative     fix
 where /* ischemictime <= 0   and */
       spec.specimen_id = sp.specimenid and
       spec.fixative_id = fix.id
 group by phase
 order by phase
