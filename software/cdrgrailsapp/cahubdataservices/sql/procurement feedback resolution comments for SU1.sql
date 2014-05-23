
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
 
select case_record_id, comments, current_submission_id, has_issue, last_updated, review_date, reviewed_by, started, status 
  from feedback 

select case_record_id, for_fzn, issue_description, last_updated, resolution_comments, specimen_record_id, submission_created_id 
  from feedback_issue 
 
select feedback_issue_id, feedback_submission_id, issue_description, last_updated, resolution_comments 
  from feedback_issue_resolution
  
select case_record_id, date_reviewed, date_submitted, feedback_version, for_fzn, internal_comments, internalguid, last_updated, 
       reviewed_by, submitted_by 
  from feedback_submission
  
select c.case_id, spec.specimen_id, tissue.name as tissue, fb.status, fbs.date_submitted, fbi.issue_description, fbi.resolution_comments, fbr.resolution_comments 
  from cdrds.dr_case                    c,
       cdrds.feedback                   fb,
       cdrds.feedback_submission        fbs,
       cdrds.feedback_issue             fbi,
       cdrds.feedback_issue_resolution  fbr,
       cdrds.dr_specimen                spec,
       cdrds.st_acquis_type             tissue
 where fbr.feedback_issue_id = fbi.id      and
       fbr.feedback_submission_id = fbs.id and
       fbi.case_record_id = c.id           and
       fbi.specimen_record_id = spec.id    and
       fbi.submission_created_id = fbs.id  and
       fbs.case_record_id = c.id           and
       fb.current_submission_id = fbs.id   and
       spec.tissue_type_id = tissue.id     and
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
