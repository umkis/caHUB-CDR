
select * from st_case_collection_type

select is_eligible, count(*) from dr_candidate group by is_eligible

select * from dr_candidate
 
select * from gtex_donor_eligibility

select id, version, abnormalwbc, active_encephalitis, active_meningitis,  allowed_min_organ_type, alzheimers, ascities, bite_from_animal, 
       blood_don_denial_reason, blood_transfusion, cancer_diag_prec5yrs, candidate_record_id, cellulites, cocaine_use, collect_in24h_death, contacthiv, 
       contact_with_smallpox, creutzfeldt_jakob, current_cancer_diag, date_created, dementia, diag_of_sars, diagnosed_metastatis, dialysis_treatment, 
       documented_sepsis, drug_abuse, drug_use_for_non_med, drugs_for_non_med5yrs, end_comments, exposure_to_toxics, fungal_infections, gonorrhea_treat, 
       growth_harmone, heart_dis, hemophilia, hemophilia_treat, hepatitisb, hepatitisc, heroin_use, high_unexplained_fever, hist_of_auto_imm_dis, 
       hist_of_infections, hist_of_reactive_assays, hist_of_sex_withhiv, hist_of_west_nile, hist_ofphysic_contact, hiv, hum_anim_tissue_transplant, 
       infected_lines, internal_comments, internalguid, intraven_drug_abuse, last_updated, lateral_sclero, longterm_steroid_use, med_history, 
       men_sex_with_men, men_with_men, multi_sclero, night_sweats, no_physical_activity, non_prof_tattoos, non_profpiercing, not_tested_for_hiv, 
       open_wounds, opp_infections, osteomyelitis, past_blood_donations, pneumonia, positive_blood_cultures, presc_drug_abuse, public_comments, 
       public_version, receive_transfusion_in48h, received_chemo_in2y, recent_smallpox_vac, resided_on_milit_base, reyes_synd, rheum_arthritis, 
       sarcoidosis, scleroderma, sex_for_drugs_or_money, sex_for_money_drugs, sex_tans_dis, sex_with_others, signs_of_drug_abuse, spots_on_skin, 
       state_run_home, syphilis_treat, syst_lupus, tbhistory, tatttoos, time_in_det_center, time_in_europe, time_in_uk, tissue_transplant_comments, 
       unexpl_cough, unexpl_lymphad, unexpl_seizures, unexpl_temp, unexpl_weightt_loss, unexpl_wkness, unexpl_wt_loss, west_nile_contact 
  from gtex_donor_eligibility

select s.case_id, elig.allowed_min_organ_type, elig.allowed_min_organ_type, age, bmi, collect_in24h_death, 
       receive_transfusion_in48h, cancer_diag_prec5yrs, current_cancer_diag, diagnosed_metastatis, received_chemo_in2y, 
       intraven_drug_abuse, hist_of_sex_withhiv, hiv, contacthiv, not_tested_for_hiv, drug_abuse, hist_of_reactive_assays
  from cdrds.dr_candidate c,
       cdrds.dr_case s,
       cdrds.gtex_donor_eligibility elig
 where is_eligible = 0
   and elig.candidate_record_id = c.id
   and c.case_record_id = s.id
   
select s.case_id, allowed_min_organ_type, age, bmi, collect_in24h_death, 
       diagnosed_metastatis, received_chemo_in2y, drug_abuse, hist_of_sex_withhiv, 
       contacthiv, hist_of_reactive_assays
  from cdrds.dr_candidate cand,
       cdrds.dr_case case,
       cdrds.gtex_donor_eligibility elig
 where is_eligible = 0
   and elig.candidate_record_id = c.id
   and cand.case_record_id = case.id
   
select bss_id, candidate_id, allowed_min_organ_type, age, bmi, collect_in24h_death, 
       diagnosed_metastatis, received_chemo_in2y, drug_abuse, hist_of_sex_withhiv, 
       contacthiv, hist_of_reactive_assays
  from cdrds.dr_candidate cand,
       cdrds.gtex_donor_eligibility elig
 where is_eligible = 0
   and elig.candidate_record_id = cand.id

/* This is the query that has potential applicability as a CDR-AR requirement.  Note the outer join */
select bss.code, candidate_id, case.case_id, allowed_min_organ_type, age, bmi, collect_in24h_death, 
       diagnosed_metastatis, received_chemo_in2y, drug_abuse, hist_of_sex_withhiv, 
       contacthiv, hist_of_reactive_assays
  from dr_candidate cand,
       gtex_donor_eligibility elig,
       dr_case case,
       st_bss bss
 where is_eligible = 0
   and elig.candidate_record_id = cand.id
   and cand.bss_id = bss.id
   and cand.case_record_id = case.id (+)
 order by bss.code
   
select * from dr_case

select id, version, case_record_id, date_created, death_circumstances_id, demographics_id, internal_comments, internalguid, last_updated, medical_history_id, public_comments, public_version, serology_result_id, status, surgical_procedures_id 
  from gtex_crf
  
select id, version, autopsy_performed, date_created, date_time_actual_death, date_time_last_seen_alive, date_time_presumed_death, date_time_pronounced_dead, death_certificate_available, estimated_hours, first_cause, first_cause_interval, immediate_cause, immediate_interval, internal_comments, internalguid, last_cause, last_cause_interval, last_updated, manner_of_death, on_ventilator, other_first_cause, other_immediate, other_last_cause, other_person_determined_death, other_place_of_death, person_determined_death, place_of_death, public_comments, public_version, ventilator_duration, was_refrigerated, hardy_scale, opo_type 
  from gtex_crf_death_circ
  
select case_id, status, manner_of_death, hardy_scale, 
       decode(immediate_cause,'Other',other_immediate,  immediate_cause) as immediate_cause,
       decode(immediate_cause,'Other',other_first_cause,first_cause)     as first_cause,
       decode(last_cause,     'Other',other_last_cause, last_cause)      as last_cause,
       was_refrigerated, estimated_hours
  from dr_case   c,
       gtex_crf  crf,
       gtex_crf_death_circ circ
 where crf.case_record_id = c.id and
       crf.death_circumstances_id = circ.id
 
select * from st_death_cause

select status, count(*) from gtex_crf group by status

select decode(immediate_cause,'Other',other_immediate,  immediate_cause) as immediate_cause, count(*)
  from gtex_crf_death_circ
  group by decode(immediate_cause,'Other',other_immediate,  immediate_cause)
  order by count(*) desc

select decode(immediate_cause,'Other',other_first_cause,first_cause)     as first_cause, count(*)
  from gtex_crf_death_circ
  group by decode(immediate_cause,'Other',other_first_cause,first_cause)
  order by count(*) desc

select decode(last_cause,     'Other',other_last_cause, last_cause)      as last_cause, count(*)
  from gtex_crf_death_circ
  group by decode(last_cause,     'Other',other_last_cause, last_cause)
  order by count(*) desc

