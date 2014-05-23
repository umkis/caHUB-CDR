select cand.candidate_id, bss.name as bss, screen.protocol_site_num, name_creat_candidate, meet_criteria, reason_not_meet, other_reason_not_meet, 
       consent_obtained, reason_not_consented, other_reason, name_consent_candidate, surgery_date, comments
  from bpv_screening_enrollment  screen,
       dr_candidate              cand,
       st_bss                    bss
 where screen.candidate_record_id = cand.id   and
       cand.bss_id = bss.id                   and
       (meet_criteria = 'No' or consent_obtained = 'No')
