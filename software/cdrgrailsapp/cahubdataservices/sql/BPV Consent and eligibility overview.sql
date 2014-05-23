select decode(is_consented, 1, 'Yes', 0, 'No') as is_consented,
       decode(is_eligible, 1, 'Yes', 0, 'No') as is_eligible, 
       Meet_criteria, reason_not_meet, count(*) as frequency
  from (
select bss_id, candidate_id, is_consented, is_eligible, study.code as study, meet_criteria, reason_not_meet, other_reason_not_meet,
       candidate_record_id, comments, consent_obtained, date_submitted, form_metadata_id, formsop_id, 
       name_consent_candidate, name_creat_candidate, other_reason, protocol_site_num, 
       reason_not_consented, submitted_by
  from dr_candidate             cand,
       st_study                 study,
       st_case_collection_type  coll_type,
       bpv_screening_enrollment bpvse
 where cand.study_id = study.id                  and
       case_collection_type_id = coll_type.id    and
       study.code in ('BPV','BRN')               and
       bpvse.candidate_record_id = cand.id
       )
 group by is_consented, is_eligible, Meet_criteria, reason_not_meet
 order by frequency desc

select decode(is_consented, 1, 'Yes', 0, 'No') as is_consented,
       decode(is_eligible, 1, 'Yes', 0, 'No') as is_eligible, 
       Meet_criteria, other_reason_not_meet, count(*) as frequency
  from (
select bss_id, candidate_id, is_consented, is_eligible, study.code as study, meet_criteria, reason_not_meet, other_reason_not_meet,
       candidate_record_id, comments, consent_obtained, date_submitted, form_metadata_id, formsop_id, 
       name_consent_candidate, name_creat_candidate, other_reason, protocol_site_num, 
       reason_not_consented, submitted_by
  from dr_candidate             cand,
       st_study                 study,
       st_case_collection_type  coll_type,
       bpv_screening_enrollment bpvse
 where cand.study_id = study.id                  and
       case_collection_type_id = coll_type.id    and
       study.code in ('BPV','BRN')               and
       bpvse.candidate_record_id = cand.id       and
       reason_not_meet = 'Other, specify'
       )
 group by is_consented, is_eligible, Meet_criteria, other_reason_not_meet
 order by frequency desc
  
