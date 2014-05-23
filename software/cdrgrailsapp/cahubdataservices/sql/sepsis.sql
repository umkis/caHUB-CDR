select case_id, status, manner_of_death, hardy_scale,                   
       immediate_cause, other_immediate,               
       first_cause,     other_first_cause,
       last_cause,      other_last_cause                            
  from cdrds.dr_case             c,                            
       cdrds.gtex_crf            crf,                            
       cdrds.gtex_crf_death_circ circ
 where crf.case_record_id = c.id            and                            
       crf.death_circumstances_id = circ.id and
       (
       upper (immediate_cause) like '%SEPSIS%' or
       upper (other_immediate) like '%SEPSIS%' or
       upper (first_cause) like '%SEPSIS%' or
       upper (other_first_cause) like '%SEPSIS%' or
       upper (last_cause) like '%SEPSIS%' or
       upper (other_last_cause) like '%SEPSIS%' or
       upper (death_certificate_cause) like '%SEPSIS%' 
       )
 order by case_id

select manner_of_death, count(*)
  from cdrds.dr_case             c,                            
       cdrds.gtex_crf            crf,                            
       cdrds.gtex_crf_death_circ circ
 where crf.case_record_id = c.id            and                            
       crf.death_circumstances_id = circ.id 
 group by manner_of_death
 
select id, version, autopsy_performed, date_created, date_time_actual_death, date_time_last_seen_alive, date_time_presumed_death, date_time_pronounced_dead, 
       death_certificate_available, estimated_hours, first_cause, first_cause_interval, immediate_cause, immediate_interval, internal_comments, internalguid, 
       last_cause, last_cause_interval, last_updated, manner_of_death, on_ventilator, other_first_cause, other_immediate, other_last_cause, other_person_determined_death, 
       other_place_of_death, person_determined_death, place_of_death, public_comments, public_version, ventilator_duration, was_refrigerated, hardy_scale, opo_type, 
       death_cert_cause_vocab_id, death_certificate_cause, first_cod_cvocab_id, imm_cod_cvocab_id, last_cod_cvocab_id, death_certificate_causev 
  from gtex_crf_death_circ
