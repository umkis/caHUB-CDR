select c.case_id, closed_by, date_closed, q.date_created, (date_closed - q.date_created) as query_duration
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
 order by case_id

select avg(date_closed - q.date_created) as query_duration
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
 order by case_id
