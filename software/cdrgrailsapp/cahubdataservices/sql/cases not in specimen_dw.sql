--case list , Anita's rule
select case_id , status.name
  from cdrds.dr_case        c,
       cdrds.st_case_status status
 where c.id in 
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
       c.case_status_id = status.id and
       case_id not in 
       ( select distinct case_id
           from cdrds.dr_case                 c,
                cdrds.dw_specimen             specdw,
                cdrds.st_bss                  bss,
                cdrds.st_case_collection_type coll_type
          where c.id in 
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
                specdw.case_record_id = c.id             and
                c.case_collection_type_id = coll_type.id and
                c.bss_id = bss.id
       )

select sdw.* 
  from cdrds.dw_specimen sdw,
       cdrds.dr_case      c
 where sdw.case_record_id = c.id and
       case_id in ('GTEX-000384')
