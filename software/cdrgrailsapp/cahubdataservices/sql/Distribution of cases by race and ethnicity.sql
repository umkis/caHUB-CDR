select c.case_id, BMI
  from cdrds.gtex_crf                crf,                
       cdrds.dr_case                 c,                
       cdrds.gtex_crf_demographics   demo,                
       cdrds.st_case_collection_type coll_type,
       cdrds.dr_candidate            cand
 where crf.case_record_id = c.id           and                
       crf.demographics_id = demo.id          and                
       c.case_collection_type_id = coll_type.id and                
       coll_type.code in ('POSTM','OPO')      and
       cand.case_record_id = c.id             and 
       cand.is_eligible = 1                   and
       c.id in 
       (select distinct persisted_object_id 
          from cdrds.audit_log 
         where class_name like '%CaseRecord%'       and
               new_value = 'BSS QA Review Complete' and 
               persisted_object_id in 
               (select id 
                  from cdrds.dr_case c 
                 where c.phase_id =
                       (select id 
                          from cdrds.st_studyphase p
                         where p.code = 'SU1') 
               ) and 
               date_created < to_date('01-Mar-2014', 'DD-Mon-YYYY')
       )
       
select gender, coll_type.code as coll_type, count(*) as frequency							
  from cdrds.gtex_crf_demographics demo,							
       cdrds.gtex_crf              crf,							
       cdrds.dr_case               case,							
       cdrds.gtex_crf_death_circ   death,							
       cdrds.dr_candidate          cand,							
       cdrds.st_case_collection_type coll_type							
 where demo.id = crf.demographics_id         and							
       crf.case_record_id = case.id          and							
       crf.death_circumstances_id = death.id and							
       case.case_collection_type_id = coll_type.id and							
       cand.case_record_id = case.id							 and
       case.id in 
       (select distinct persisted_object_id 
          from cdrds.audit_log 
         where class_name like '%CaseRecord%'       and
               new_value = 'BSS QA Review Complete' and 
               persisted_object_id in 
               (select id 
                  from cdrds.dr_case c 
                 where c.phase_id =
                       (select id 
                          from cdrds.st_studyphase p
                         where p.code = 'SU1') 
               ) and 
               date_created < to_date('01-Mar-2014', 'DD-Mon-YYYY')
       )
 group by gender, coll_type.code							
 order by gender, coll_type.code
 
 
select demo.race, demo.ethnicity, count(*) as frequency							
  from cdrds.gtex_crf_demographics demo,							
       cdrds.gtex_crf              crf,							
       cdrds.dr_case               case,							
       cdrds.gtex_crf_death_circ   death,							
       cdrds.dr_candidate          cand,							
       cdrds.st_case_collection_type coll_type							
 where demo.id = crf.demographics_id         and							
       crf.case_record_id = case.id          and							
       crf.death_circumstances_id = death.id and							
       case.case_collection_type_id = coll_type.id and							
       cand.case_record_id = case.id							 and
       case.id in 
       (select distinct persisted_object_id 
          from cdrds.audit_log 
         where class_name like '%CaseRecord%'       and
               new_value = 'BSS QA Review Complete' and 
               persisted_object_id in 
               (select id 
                  from cdrds.dr_case c 
                 where c.phase_id =
                       (select id 
                          from cdrds.st_studyphase p
                         where p.code = 'SU1') 
               ) and 
               date_created < to_date('01-Mar-2014', 'DD-Mon-YYYY')
       )
 group by demo.race, demo.ethnicity							
 order by demo.race, demo.ethnicity
