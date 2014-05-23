select c.case_id, spec.specimen_id, fix.name as fixative, tissue.name as tissue, fb.status, fbs.date_submitted, fbi.issue_description, fbi.resolution_comments, fbr.resolution_comments 
  from cdrds.dr_case                    c,
       cdrds.feedback                   fb,
       cdrds.feedback_submission        fbs,
       cdrds.feedback_issue             fbi,
       cdrds.feedback_issue_resolution  fbr,
       cdrds.dr_specimen                spec,
       cdrds.st_acquis_type             tissue,
       cdrds.st_fixative                fix
 where fbr.feedback_issue_id = fbi.id      and
       fbr.feedback_submission_id = fbs.id and
       fbi.case_record_id = c.id           and
       fbi.specimen_record_id = spec.id    and
       fbi.submission_created_id = fbs.id  and
       fbs.case_record_id = c.id           and
       fb.current_submission_id = fbs.id   and
       spec.tissue_type_id = tissue.id     and
       spec.fixative_id = fix.id           and
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
