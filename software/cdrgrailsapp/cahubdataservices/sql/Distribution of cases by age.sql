select c.case_id, q.id, closed_by, date_closed, q.date_created, (date_closed - q.date_created) as query_duration
  from cdrds.query     q,
       cdrds.dr_case   c,
       cdrds.st_study  study
 where q.case_record_id = c.id and
       q.study_id = study.id   and
       study.code = 'GTEX'     and
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
 order by case_id, q.id
 
select case                
         when (age_for_index >= 21) and (age_for_index <= 30) then '21 - 30'                
         when (age_for_index >= 31) and (age_for_index <= 40) then '31 - 40'                
         when (age_for_index >= 41) and (age_for_index <= 50) then '41 - 50'                
         when (age_for_index >= 51) and (age_for_index <= 60) then '51 - 60'                
         when (age_for_index >= 61) and (age_for_index <= 70) then '61 - 70'                
           else to_char(age_for_index)                
         end as age_bucket, coll_type.code as coll_type, count(*) as frequency                
  from cdrds.gtex_crf_demographics demo,                
       cdrds.gtex_crf              crf,                
       cdrds.dr_case               case,                
       cdrds.gtex_crf_death_circ   death,                
       cdrds.dr_candidate          cand,                
       cdrds.st_case_collection_type coll_type                
 where demo.id = crf.demographics_id         and                
       crf.case_record_id = case.id          and                
       crf.death_circumstances_id = death.id and                
       cand.is_eligible = 1                  and                
       case.case_collection_type_id = coll_type.id and                
       cand.case_record_id = case.id               and
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
 group by case                
         when (age_for_index >= 21) and (age_for_index <= 30) then '21 - 30'                
         when (age_for_index >= 31) and (age_for_index <= 40) then '31 - 40'								
         when (age_for_index >= 41) and (age_for_index <= 50) then '41 - 50'								
         when (age_for_index >= 51) and (age_for_index <= 60) then '51 - 60'								
         when (age_for_index >= 61) and (age_for_index <= 70) then '61 - 70'								
           else to_char(age_for_index)								
         end, coll_type.code								
 order by case								
         when (age_for_index >= 21) and (age_for_index <= 30) then '21 - 30'								
         when (age_for_index >= 31) and (age_for_index <= 40) then '31 - 40'								
         when (age_for_index >= 41) and (age_for_index <= 50) then '41 - 50'								
         when (age_for_index >= 51) and (age_for_index <= 60) then '51 - 60'								
         when (age_for_index >= 61) and (age_for_index <= 70) then '61 - 70'								
           else to_char(age_for_index)								
         end, coll_type.code
