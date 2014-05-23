select avg_fix_time, brain, case_record_id, ischemic_time, latest_rin, 
       max_fix_time, min_fix_time, procedure_duration, procedure_type_id, specimen_id, tissue_location_id, 
       tissue_type_id 
  from cdrds.dw_specimen  sdw,
       cdrds.dr_case      c
 where brain = 'No' and
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
       ) and
       sdw.min_fix_time >= (8 * 60 * 60 * 1000)
