select case_id, brain, ischemic_time, latest_rin, 
       min_fix_time, max_fix_time, procedure_duration
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

select distinct case_id, brain, 
      max_fix_time
  from cdrds.dw_specimen  sdw,
       cdrds.dr_case      c
 where brain = 'Yes'             and
       sdw.case_record_id = c.id and
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
       sdw.max_fix_time >= (25 * 60 * 60 * 1000)
       order by case_id
