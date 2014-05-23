
select bss.code as bss, candidate_id, 
       decode(is_consented, 1, 'Yes', 0, 'No') as is_consented,
       decode(is_eligible, 1, 'Yes', 0, 'No') as is_eligible,  
       study.code as study, meet_criteria, reason_not_meet, other_reason_not_meet,
       bpvse.consent_obtained,
       bpvse.reason_not_consented,
       other_reason, 
       bpvse.comments,
       date_submitted, 
       name_consent_candidate, name_creat_candidate, 
       submitted_by
  from dr_candidate             cand,
       st_study                 study,
       st_bss                   bss,
       st_case_collection_type  coll_type,
       bpv_screening_enrollment bpvse
 where cand.study_id = study.id                  and
       case_collection_type_id = coll_type.id    and
       cand.bss_id = bss.id                      and
       study.code in ('BPV','BRN')               and
       bpvse.candidate_record_id = cand.id       and
       is_consented = 0 and is_eligible = 0      and
       meet_criteria = 'Yes'
       
