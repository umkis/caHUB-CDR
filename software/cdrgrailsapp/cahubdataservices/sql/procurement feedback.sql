
select case_id,  comments, has_issue, review_date, reviewed_by, started, status 
  from cdrds.feedback                   feedback,
       cdrds.dr_case                    c
 where feedback.case_record_id = c.id                  and
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
 
