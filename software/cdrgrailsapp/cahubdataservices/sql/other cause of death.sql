
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

select distinct(manner_of_death), count(*) as frequency
  from gtex_crf_death_circ
group by manner_of_death

select * from st_case_collection_type

select code, count(*)
  from dr_case,
       st_case_status
 where dr_case.case_status_id = st_case_status.id
 group by code

/* 21-Aug-2012 */
select case_id, stat.code||': '||stat.description as case_status, coll.description, manner_of_death, hardy_scale, 
       immediate_cause,  other_immediate,  
       first_cause,      other_first_cause,
       last_cause,       other_last_cause
  from dr_case                 c,
       gtex_crf                crf,
       gtex_crf_death_circ     circ,
       st_case_collection_type coll,
       st_case_status          stat
 where crf.case_record_id = c.id            and
       crf.death_circumstances_id = circ.id and
       c.case_collection_type_id  = coll.id and
       c.case_status_id = stat.id           and
       coll.code in ('POSTM','OPO')         and
       stat.code in ('RELE')
 order by case_id
 
select * from st_death_cause

select status, count(*) from gtex_crf group by status

select case_id,
       c.case_status_id,
       dc.hardy_scale,
       decode(immediate_cause,'Other',other_immediate,  immediate_cause) as immediate_cause,
       decode(first_cause,'Other',other_first_cause,first_cause)     as first_cause,
       decode(last_cause,     'Other',other_last_cause, last_cause)      as last_cause
  from gtex_crf_death_circ  dc,
       gtex_crf             crf,
       dr_case              c
 where crf.death_circumstances_id = dc.id and
       crf.case_record_id = c.id
 order by case_id
 
select decode(immediate_cause,'Other',other_immediate_cause,immediate_cause)     as immediate_cause, count(*)
  from gtex_crf_death_circ
 where immediate_cause is not null
  group by decode(immediate_cause,'Other',other_immediate,  immediate_cause)
  order by count(*) desc

select decode(first_cause,'Other',other_first_cause,first_cause)     as first_cause, count(*)
  from gtex_crf_death_circ
 where first_cause is not null
 group by decode(first_cause,'Other',other_first_cause,first_cause)
 order by count(*) desc

select decode(last_cause,     'Other',other_last_cause, last_cause)      as last_cause, count(*)
  from gtex_crf_death_circ
  group by decode(last_cause,     'Other',other_last_cause, last_cause)
  order by count(*) desc

select case_id, stat.code||': '||stat.description as case_status, coll.description, manner_of_death, hardy_scale, 
       decode(immediate_cause,'Other', other_immediate,  immediate_cause) as immediate_cause,
       decode(first_cause,    'Other', other_first_cause,first_cause)     as first_cause,
       decode(last_cause,     'Other', other_last_cause, last_cause)      as last_cause
  from dr_case                 c,
       gtex_crf                crf,
       gtex_crf_death_circ     circ,
       st_case_collection_type coll,
       st_case_status          stat
 where crf.case_record_id = c.id            and
       crf.death_circumstances_id = circ.id and
       c.case_collection_type_id  = coll.id and
       c.case_status_id = stat.id           and
       coll.code in ('POSTM','OPO')         and
       stat.code in ('RELE')                and
 order by case_id
 


select case_id, stat.code||': '||stat.description as case_status, coll.description, 
       decode(immediate_cause,'Other',other_immediate,  immediate_cause) as immediate_cause,
       decode(first_cause,'Other',other_first_cause,  first_cause) as first_cause
  from dr_case                 c,
       gtex_crf                crf,
       gtex_crf_death_circ     circ,
       st_case_collection_type coll,
       st_case_status          stat
 where (immediate_cause = 'trauma SAH/SDH' or other_immediate = 'trauma SAH/SDH')   and
       crf.case_record_id = c.id            and
       crf.death_circumstances_id = circ.id and
       c.case_collection_type_id  = coll.id and
       c.case_status_id = stat.id           

/* dr_specimen (n) = 10,068 */
/* case x specimen = 9909   */
select specimen_id, aqtype.name, 
       circ.date_time_actual_death, circ.date_time_pronounced_dead, circ.date_time_presumed_death, circ.date_time_last_seen_alive,
       decode(circ.date_time_actual_death, null, 
         decode(circ.date_time_pronounced_dead, null, 
           decode(circ.date_time_presumed_death, null, circ.date_time_last_seen_alive), 
                circ.date_time_pronounced_dead),
              circ.date_time_actual_death) as calc_death,
       aliquot_time_fixed, aliquot_time_removed, 
       aliquot_time_stabilized, 
       blood_time_draw, blood_time_draw_inverted, 
       brain_time_end_aliquot, brain_time_ice, brain_time_start_removal, 
       fixative_id, in_quarantine, other_tissue_location, prosector_comments, provisional_tissue_type_id, 
       skin_time_into_medium, tissue_location_id, is_depleted, parent_specimen_id, tumor_status_id, was_consumed, prc_specimen_id, container_type_id, protocol_id 
  from dr_specimen             spec,
       st_acquis_type          aqtype,
       gtex_crf                crf,
       gtex_crf_death_circ     circ,
       dr_case
 where spec.tissue_type_id = aqtype.id  and
       spec.case_record_id = dr_case.id and 
       crf.case_record_id  = dr_case.id and
       crf.death_circumstances_id = circ.id 
 order by specimen_id

select count(*) from dr_specimen

/* Immediate / Other Immediate */
select case_id, stat.code||': '||stat.description as case_status, coll.description, manner_of_death, hardy_scale, 
       immediate_cause
  from dr_case                 c,
       gtex_crf                crf,
       gtex_crf_death_circ     circ,
       st_case_collection_type coll,
       st_case_status          stat
 where immediate_cause != 'Other'            and
       crf.case_record_id = c.id            and
       crf.death_circumstances_id = circ.id and
       c.case_collection_type_id  = coll.id and
       c.case_status_id = stat.id           and
       coll.code in ('POSTM','OPO')         and
       stat.code in ('RELE')
 order by case_id

select case_id, stat.code||': '||stat.description as case_status, coll.description, manner_of_death, hardy_scale, 
       other_immediate
  from dr_case                 c,
       gtex_crf                crf,
       gtex_crf_death_circ     circ,
       st_case_collection_type coll,
       st_case_status          stat
 where immediate_cause = 'Other'            and
       crf.case_record_id = c.id            and
       crf.death_circumstances_id = circ.id and
       c.case_collection_type_id  = coll.id and
       c.case_status_id = stat.id           and
       coll.code in ('POSTM','OPO')         and
       stat.code in ('RELE')
 order by case_id  

/* First / Other First */
select case_id, stat.code||': '||stat.description as case_status, coll.description, manner_of_death, hardy_scale, 
       first_cause
  from dr_case                 c,
       gtex_crf                crf,
       gtex_crf_death_circ     circ,
       st_case_collection_type coll,
       st_case_status          stat
 where first_cause    != 'Other'            and
       crf.case_record_id = c.id            and
       crf.death_circumstances_id = circ.id and
       c.case_collection_type_id  = coll.id and
       c.case_status_id = stat.id           and
       coll.code in ('POSTM','OPO')         and
       stat.code in ('RELE')
 order by case_id

select case_id, stat.code||': '||stat.description as case_status, coll.description, manner_of_death, hardy_scale, 
       other_first_cause
  from dr_case                 c,
       gtex_crf                crf,
       gtex_crf_death_circ     circ,
       st_case_collection_type coll,
       st_case_status          stat
 where first_cause = 'Other'            and
       crf.case_record_id = c.id            and
       crf.death_circumstances_id = circ.id and
       c.case_collection_type_id  = coll.id and
       c.case_status_id = stat.id           and
       coll.code in ('POSTM','OPO')         and
       stat.code in ('RELE')
 order by case_id
 
/* Last / Other Last */
select case_id, stat.code||': '||stat.description as case_status, coll.description, manner_of_death, hardy_scale, 
       last_cause
  from dr_case                 c,
       gtex_crf                crf,
       gtex_crf_death_circ     circ,
       st_case_collection_type coll,
       st_case_status          stat
 where last_cause    != 'Other'            and
       crf.case_record_id = c.id            and
       crf.death_circumstances_id = circ.id and
       c.case_collection_type_id  = coll.id and
       c.case_status_id = stat.id           and
       coll.code in ('POSTM','OPO')         and
       stat.code in ('RELE')
 order by case_id

select case_id, stat.code||': '||stat.description as case_status, coll.description, manner_of_death, hardy_scale, 
       other_last_cause
  from dr_case                 c,
       gtex_crf                crf,
       gtex_crf_death_circ     circ,
       st_case_collection_type coll,
       st_case_status          stat
 where last_cause = 'Other'            and
       crf.case_record_id = c.id            and
       crf.death_circumstances_id = circ.id and
       c.case_collection_type_id  = coll.id and
       c.case_status_id = stat.id           and
       coll.code in ('POSTM','OPO')         and
       stat.code in ('RELE')
 order by case_id

select other_immediate,  count(*)
  from gtex_crf_death_circ
  group by other_immediate
  order by count(*) desc

select other_first_cause,  count(*)
  from gtex_crf_death_circ
  group by other_first_cause
  order by count(*) desc

select other_last_cause,  count(*)
  from gtex_crf_death_circ
  group by other_last_cause
  order by count(*) desc

/* Freqs of null GTEx fields: */
select c.id, c.version, bss_id, case_collection_type_id, case_id, case_status_id, c.date_created, c.internal_comments, c.internalguid, kit_list, c.last_updated, c.public_comments, c.public_version, study_id, cdr_ver, experiment, primary_tissue_type_id, parent_case_id, 
       s.id, s.version, aliquot_time_fixed, aliquot_time_removed, aliquot_time_stabilized, blood_time_draw, blood_time_draw_inverted, brain_time_end_aliquot, brain_time_ice, brain_time_start_removal, case_record_id, s.date_created, fixative_id, in_quarantine, s.internal_comments, s.internalguid, s.last_updated, other_tissue_location, prosector_comments, provisional_tissue_type_id, s.public_comments, s.public_id, s.public_version, size_diff_thansop, skin_time_into_medium, specimen_id, tissue_location_id, tissue_type_id, is_depleted, parent_specimen_id, tumor_status_id, was_consumed, prc_specimen_id, container_type_id, protocol_id
  from dr_case      c,
       dr_specimen  s
 where s.case_record_id = c.id

select count(*) as case_count from dr_case

select count(*) as crf_count from gtex_crf

select count(*) as death_circ_count from gtex_crf_death_circ

select count(*) as demographics_count from gtex_crf_demographics

select count(*) as medic_history_count from gtex_crf_medic_his

select count(*) as general_medic_his_count from gtex_crf_general_medic_his

select c.case_id, coll_type.name as coll_type, bss.name as BSS, demog.gender, demog.other_gender, date_of_birth, age_for_index, height, weight, bmi, race, 
       decode(race_asian,0,'No','Yes') as race_asian, 
       decode(race_black_american,0,'No','Yes') as race_black, 
       decode(race_hawaiian,0,'No','Yes') as race_hawaiian,
       decode(race_indian,0,'No','Yes') as race_indian, 
       decode(race_unknown,0,'No','Yes') as race_unknown, 
       decode(race_white,0,'No','Yes') as race_white, 
       ethnicity, 
       source, primary, other_primary, non_metastatic_cancer, 
       death_certificate_available, date_time_pronounced_dead, date_time_actual_death, date_time_presumed_death, date_time_last_seen_alive, place_of_death, other_place_of_death, 
         person_determined_death, other_person_determined_death, manner_of_death, 
         decode(hardy_scale,1,'One',2,'Two',3,'Three',4,'Four',0,'Zero') as hardy_scale,
         autopsy_performed, on_ventilator, ventilator_duration, 
         immediate_cause, immediate_interval, other_immediate, first_cause, first_cause_interval, other_first_cause, last_cause, last_cause_interval, other_last_cause, 
         was_refrigerated, estimated_hours, opo_type,
       death_circumstances_id, 
       demographics_id, medical_history_id, serology_result_id, status, surgical_procedures_id
  from dr_case                 c,
       gtex_crf                crf,
       gtex_crf_death_circ     death_circ,
       gtex_crf_demographics   demog,
       st_bss                  bss,
       st_case_collection_type coll_type,
       gtex_crf_medic_his      medic_his
 where c.bss_id = bss.id                       and
       crf.case_record_id = c.id               and
       death_circumstances_id = death_circ.id  and
       demographics_id = demog.id              and
       case_collection_type_id = coll_type.id  and
       crf.medical_history_id = medic_his.id
 order by c.case_id
 
 
select * 
  from gtex_crf
       
select id, version, autopsy_performed, date_created, date_time_actual_death, date_time_last_seen_alive, date_time_presumed_death, date_time_pronounced_dead, death_certificate_available, estimated_hours, first_cause, first_cause_interval, immediate_cause, immediate_interval, internal_comments, internalguid, last_cause, last_cause_interval, last_updated, manner_of_death, on_ventilator, other_first_cause, other_immediate, other_last_cause, other_person_determined_death, other_place_of_death, person_determined_death, place_of_death, public_comments, public_version, ventilator_duration, was_refrigerated, hardy_scale, opo_type 
  from gtex_crf_death_circ

select id, version, bmi, date_of_birth, ethnicity, gender, height, other_gender, race, race_asian, race_black_american, race_hawaiian, race_indian, race_unknown, race_white, weight, age_for_index 
  from gtex_crf_demographics
  
select id, version, date_created, internal_comments, internalguid, last_updated, non_metastatic_cancer, other_primary, primary, public_comments, public_version, source 
  from gtex_crf_medic_his
  
select id, version, choose_option, date_created, display_order, internal_comments, internalguid, last_updated, medical_condition, medical_history_id, medical_record, public_comments, public_version, rown, treatment, year_of_onset 
  from gtex_crf_general_medic_his
  
select distinct medical_condition from gtex_crf_general_medic_his

select id, version, date_created, internal_comments, internalguid, last_updated, medical_history_id, medical_record_exist, month_year_of_first_diagnosis, month_year_of_last_treatment, other_treatment, primary_tumor_site, public_comments, public_version, treatment_chemotherapy, treatment_no, treatment_other, treatment_radiation, treatment_surgery, treatment_unknown, treatments 
  from gtex_crf_cancer_history
 order by id
 
select c.case_id, coll_type.name as coll_type, bss.code as BSS, demog.gender, demog.other_gender, date_of_birth, age_for_index, height, weight, bmi, race, 
       decode(race_asian,0,'No','Yes') as race_asian, 
       decode(race_black_american,0,'No','Yes') as race_black, 
       decode(race_hawaiian,0,'No','Yes') as race_hawaiian,
       decode(race_indian,0,'No','Yes') as race_indian, 
       decode(race_unknown,0,'No','Yes') as race_unknown, 
       decode(race_white,0,'No','Yes') as race_white, 
       ethnicity, 
       source, primary, other_primary, non_metastatic_cancer, 
       death_certificate_available, date_time_pronounced_dead, date_time_actual_death, date_time_presumed_death, date_time_last_seen_alive, place_of_death, other_place_of_death, 
         person_determined_death, other_person_determined_death, manner_of_death, 
         decode(hardy_scale,0,'0. Zero',1,'1. One',2,'2. Two',3,'3. Three',4,'4. Four') as hardy_scale,
         autopsy_performed, on_ventilator, ventilator_duration, 
         immediate_cause, immediate_interval, other_immediate, first_cause, first_cause_interval, other_first_cause, last_cause, last_cause_interval, other_last_cause, 
         was_refrigerated, estimated_hours, opo_type,
       death_circumstances_id, 
       demographics_id, medical_history_id, serology_result_id, status, surgical_procedures_id
  from dr_case                 c,
       gtex_crf                crf,
       gtex_crf_death_circ     death_circ,
       gtex_crf_demographics   demog,
       st_bss                  bss,
       st_case_collection_type coll_type,
       gtex_crf_medic_his      medic_his
 where c.bss_id = bss.id                       and
       crf.case_record_id = c.id               and
       death_circumstances_id = death_circ.id  and
       demographics_id = demog.id              and
       case_collection_type_id = coll_type.id  and
       crf.medical_history_id = medic_his.id 
 order by c.case_id

Select other_last_cause, count(*) as Frequency
  from dr_case                 c,
       gtex_crf                crf,
       gtex_crf_death_circ     death_circ,
       gtex_crf_demographics   demog,
       st_bss                  bss,
       st_case_collection_type coll_type,
       gtex_crf_medic_his      medic_his
 where c.bss_id = bss.id                       and
       crf.case_record_id = c.id               and
       death_circumstances_id = death_circ.id  and
       demographics_id = demog.id              and
       case_collection_type_id = coll_type.id  and
       crf.medical_history_id = medic_his.id
 group by other_last_cause
 order by other_last_cause

select id, version, choose_option, date_created, display_order, internal_comments, internalguid, last_updated, medical_condition, medical_history_id, medical_record, public_comments, public_version, rown, treatment, year_of_onset 
  from gtex_crf_general_medic_his

select c.case_id, bss.code as BSS,
       choose_option, display_order, gmedic_his.internal_comments, gmedic_his.internalguid, gmedic_his.last_updated, medical_condition, gmedic_his.medical_history_id, medical_record, 
       gmedic_his.public_comments,gmedic_his. public_version, rown, treatment, decode(year_of_onset, null, 'Not Answered', 'Answered') as Year_was_answered
  from dr_case                     c,
       st_bss                      bss,
       gtex_crf                    crf,
       gtex_crf_medic_his          medic_his,
       gtex_crf_general_medic_his  gmedic_his
 where c.bss_id = bss.id                     and
       c.id = crf.case_record_id             and
       crf.medical_history_id = medic_his.id and
       gmedic_his.medical_history_id = medic_his.id
       and choose_option = 'Yes'
 order by c.case_id, display_order

select distinct medical_condition from gtex_crf_general_medic_his

/* crosstabs by BSS: */
select id, version, code, description, name, rown from st_medical_condition  

select c.case_id, bss.code as BSS, count(*) 
  from dr_case                     c,
       st_bss                      bss,
       gtex_crf                    crf,
       gtex_crf_medic_his          medic_his,
       gtex_crf_general_medic_his  gmedic_his
 where c.id = crf.case_record_id             and
       c.bss_id = bss.id                     and
       crf.medical_history_id = medic_his.id and
       gmedic_his.medical_history_id = medic_his.id
       and choose_option = 'Yes'
 group by c.case_id, bss.code
 order by bss.code
 
select distinct d.case_id, t.name, trf.collection_date, TO_CHAR(trf.collection_date, 'yyyy q') as quarter
  from cdrds.dr_case d, 
       cdrds.dr_specimen s, 
       cdrds.st_acquis_type t, 
       cdrds.gtex_tissue_recovery trf
 where d.id = s.case_record_id and 
       t.id = s.tissue_type_id and 
       d.id = trf.case_record_id (+)  and 
       case_id like 'GTEX%'
 order by case_id, name

/* Nancy's count of specimens by Quarter */ 
select TO_CHAR(trf.collection_date, 'yyyy q') as quarter, count(t.name) as specimens
  from cdrds.dr_case d, 
       cdrds.dr_specimen s, 
       cdrds.st_acquis_type t, 
       cdrds.gtex_tissue_recovery trf
 where d.id = s.case_record_id and 
       t.id = s.tissue_type_id and 
       d.id = trf.case_record_id (+)  and 
       case_id like 'GTEX%'
 group by TO_CHAR(trf.collection_date, 'yyyy q')
 order by TO_CHAR(trf.collection_date, 'yyyy q')

select TO_CHAR(trf.collection_date, 'yyyy q') as quarter, count(t.name) as specimens
  from dr_case              c, 
       dr_specimen          s, 
       st_acquis_type       t, 
       gtex_tissue_recovery trf
 where c.id = s.case_record_id        and 
       t.id = s.tissue_type_id        and 
       c.id = trf.case_record_id (+)  and 
       case_id like 'GTEX%'
 group by TO_CHAR(trf.collection_date, 'yyyy q')
 order by TO_CHAR(trf.collection_date, 'yyyy q')

select d.case_id, t.name, 
       case
         when (trf.collection_date >= to_Date('01/01/2011','mm/dd/yyyy')) and (trf.collection_date <= to_Date('08/31/2011','mm/dd/yyyy')) then '1Q (2)	January 2011 thru August 2011 (Beta)' 
         when (trf.collection_date >= to_Date('09/01/2011','mm/dd/yyyy')) and (trf.collection_date <= to_Date('11/30/2011','mm/dd/yyyy')) then '2Q (3)	September 2011 thru November 2011 (Accrual)' 
         when (trf.collection_date >= to_Date('01/12/2011','mm/dd/yyyy')) and (trf.collection_date <= to_Date('02/29/2012','mm/dd/yyyy')) then '3Q (4)	December 2011 thru February 2012 (Accrual)' 
         when (trf.collection_date >= to_Date('03/01/2012','mm/dd/yyyy')) and (trf.collection_date <= to_Date('05/30/2012','mm/dd/yyyy')) then '4Q (5)	March 2012 thru May 2012 (Accrual)'
         when (trf.collection_date >= to_Date('06/01/2012','mm/dd/yyyy')) and (trf.collection_date <= to_Date('09/30/2012','mm/dd/yyyy')) then '5Q (6)	June 2012 thru September 2012 (Accrual)'
         end as quarter
  from cdrds.dr_case d, cdrds.dr_specimen s, cdrds.st_acquis_type t, cdrds.gtex_tissue_recovery trf
 where d.id = s.case_record_id and t.id = s.tissue_type_id and d.id = trf.case_record_id (+)  and case_id like 'GTEX%' order by case_id, name




/* -------------------------------------- */

/* Data Analysis for Anita */
select d.privateId, s.privateId, s.tissueSiteDetail, r.value  
  from Donor d inner join 
       d.specimens s inner join 
       s.qcs q inner join 
       q.qcResults r, 
       CaseRecord cd 
 where d.caseRecord =cd and 
       r.attribute='RIN Number' 
 order by cd.dateCreated desc
 
select id, version, case_record_id, date_created, internal_comments, internalguid, last_updated, lsid, private_id, public_comments, public_id, public_version, raw_data 
  from ldacc_donor 
  
select id, version, date_created, date_run, internal_comments, internalguid, last_updated, lsid, protocol_name, public_comments, public_version, specimen_id, stock_id 
  from ldacc_qc

select id, version, attribute, date_created, internal_comments, internalguid, last_updated, public_comments, public_version, qc_id, value 
  from ldacc_qc_result

select raw_data 
  from ldacc_donor

select id, version, date_created, donor_id, internal_comments, internalguid, last_updated, lsid, material_type, private_id, public_comments, public_id, public_version, receipt_date, receipt_note, specimen_record_id, tissue_site, tissue_site_detail 
  from ldacc_specimen

select id, version, date_created, date_run, internal_comments, internalguid, last_updated, protocol_name, public_comments, public_version, specimen_id 
  from ldacc_extraction

select count(*) from ldacc_donor

select *
  from dr_case          c,
       ldacc_donor      ld,
       ldacc_specimen   ls,
       ldacc_qc         lq,
       ldacc_qc_result  lr
 where c.id = ld.case_record_id and
       ld.id = ls.donor_id      and
       ls.id = lq.specimen_id   and
       lq.id = lr.qc_id         and
       lr.attribute = 'RIN Number'
 order by ls.public_id

select ls.private_id, tissue_site, tissue_site_detail, lr.attribute, lr.value
  from dr_case          c,
       ldacc_donor      ld,
       ldacc_specimen   ls,
       ldacc_qc         lq,
       ldacc_qc_result  lr
 where c.id = ld.case_record_id and
       ld.id = ls.donor_id      and
       ls.id = lq.specimen_id   and
       lq.id = lr.qc_id         and
       lr.attribute = 'RIN Number'
 order by ls.private_id

select distinct lr.value
  from dr_case          c,
       ldacc_donor      ld,
       ldacc_specimen   ls,
       ldacc_qc         lq,
       ldacc_qc_result  lr
 where c.id = ld.case_record_id and
       ld.id = ls.donor_id      and
       ls.id = lq.specimen_id   and
       lq.id = lr.qc_id         and
       lr.attribute = 'RIN Number'
       and instr(lr.value, '-') !=0
 order by lr.value

select date_created from dr_case where rownum <= 9

select id, version, autolysis, caption, comments, prc.date_created, file_path, prc.internal_comments, inventory_status_id, prc.last_updated, prc.public_comments, specimen_record_id 
  from prc_specimen prc,
       dr_specimen  spec,
       dr_case      case
 where case.case_id = 'GTEX-000110'  and
       spec.case_record_id = case.id and
       prc.specimen_record_id = spec.id

