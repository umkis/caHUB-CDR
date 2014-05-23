select c.case_id, elig.hum_anim_tissue_transplant, elig.tissue_transplant_comments
  from cdrds.gtex_donor_eligibility elig,
       cdrds.dr_case                c,
       cdrds.dr_candidate           cand
 where elig.candidate_record_id = cand.id and
       cand.case_record_id = c.id         and
       hum_anim_tissue_transplant = 'Yes' and
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


