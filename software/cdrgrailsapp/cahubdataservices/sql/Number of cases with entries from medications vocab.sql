
select case_id, medication_name, meds.medication_name_cvocab_id
  from gtex_crf_concomitant_med meds,
       gtex_crf                 crf,
       dr_candidate               cand,
       st_case_status             status,
       st_study                   study,
       st_bss                     bss,
       st_bss                     parent_bss,
       dr_case                  c
 where meds.case_report_form_id = crf.id and
       crf.case_record_id = c.id         and
       c.case_status_id = status.id  and
       c.study_id = study.id         and
       c.bss_id         = bss.id     and
       bss.parent_bss_id   = parent_bss.id and
       cand.case_record_id = c.id    and
       study.code = 'GTEX'           and
       cand.is_consented = 1         and
       cand.is_eligible  = 1         and
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
 
 
select case_id, count(*) as meds_per_case
  from gtex_crf_concomitant_med meds,
       gtex_crf                 crf,
       dr_candidate               cand,
       st_case_status             status,
       st_study                   study,
       st_bss                     bss,
       st_bss                     parent_bss,
       dr_case                  c
 where meds.case_report_form_id = crf.id and
       crf.case_record_id = c.id         and
       c.case_status_id = status.id  and
       c.study_id = study.id         and
       c.bss_id         = bss.id     and
       bss.parent_bss_id   = parent_bss.id and
       cand.case_record_id = c.id    and
       study.code = 'GTEX'           and
       cand.is_consented = 1         and
       cand.is_eligible  = 1         and
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
 group by case_id

select case_id, decode(meds.medication_name_cvocab_id, null, '', 'Vocab'), count(*)
  from gtex_crf_concomitant_med meds,
       gtex_crf                 crf,
       dr_candidate               cand,
       st_case_status             status,
       st_study                   study,
       st_bss                     bss,
       st_bss                     parent_bss,
       dr_case                  c
 where meds.case_report_form_id = crf.id and
       crf.case_record_id = c.id         and
       c.case_status_id = status.id  and
       c.study_id = study.id         and
       c.bss_id         = bss.id     and
       bss.parent_bss_id   = parent_bss.id and
       cand.case_record_id = c.id    and
       study.code = 'GTEX'           and
       cand.is_consented = 1         and
       cand.is_eligible  = 1         and
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
 group by case_id, decode(meds.medication_name_cvocab_id, null, '', 'Vocab')
 
