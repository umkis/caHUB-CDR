/* Output saved as BPV Eligible Cases3.xlsx and delivered to R Agarwal on 9-Apr-2013 */
select bss.code as bss, /* candidate_id, */ case_id,
       decode(is_consented, 1, 'Yes', 0, 'No') as is_consented,
       decode(is_eligible, 1, 'Yes', 0, 'No') as is_eligible, 
       study.code as study, meet_criteria,  /* reason_not_meet, other_reason_not_meet, */
       status.name as case_status,
       bpvb.blood_minimum,
       bpvtge.excess_released, bpvtge.no_release_reason,
       bpvqc.was_stopped, bpvqc.reason_stopped, bpvqc.other_reason, bpvqc.date_created,
       comments, consent_obtained, bpvse.date_submitted,  
       bpvse.other_reason as Oth_non_consent_reason, bpvse.protocol_site_num, 
       reason_not_consented, bpvse.submitted_by,
       bpvqc.tubes as required_blood, bpvqc.tumor_module, bpvqc.additional_module, bpvqc.project_criteria
  from dr_case                  c,
       dr_candidate             cand,
       st_study                 study,
       st_bss                   bss,
       st_case_collection_type  coll_type,
       st_case_status           status,
       bpv_screening_enrollment bpvse,
       bpv_blood_form           bpvb,
       bpv_tissue_gross_evaluation bpvtge,
       bpv_case_quality_review  bpvqc
 where cand.case_record_id = c.id                      and
       bpvqc.case_record_id(+) = c.id                  and
       bpvb.case_record_id(+)  = c.id                  and
       bpvtge.case_record_id(+)= c.id                  and
       cand.study_id = study.id                        and
       c.case_status_id = status.id                    and
       cand.bss_id = bss.id                            and
       cand.case_collection_type_id = coll_type.id     and
       study.code in ('BPV','BRN')                     and
       bpvse.candidate_record_id = cand.id             /*and
       decode(is_consented, 1, 'Yes', 0, 'No') = 'Yes' and 
       decode(is_Eligible, 1, 'Yes', 0, 'No') = 'Yes' */
 /*   and
       bpvqc.tumor_module = 'Yes' and bpvqc.project_criteria = 'No' */
