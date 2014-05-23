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
