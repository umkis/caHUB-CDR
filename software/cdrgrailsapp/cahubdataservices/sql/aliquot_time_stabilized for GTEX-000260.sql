   
select st_bss.code, specimen_id, st_acquis_type.name, st_acquis_loc.name,
       aliquot_time_removed, aliquot_time_fixed, aliquot_time_stabilized, 
       blood_time_draw, blood_time_draw_inverted, skin_time_into_medium, 
       brain_time_ice, brain_time_start_removal, brain_time_end_aliquot, 
       fixative_id, in_quarantine, prosector_comments, size_diff_thansop, 
       is_depleted, parent_specimen_id, tumor_status_id, was_consumed, prc_specimen_id, container_type_id, protocol_id 
  from dr_case,
       dr_specimen,
       st_acquis_type,
       st_acquis_loc,
       st_bss
 where dr_specimen.tissue_type_id = st_acquis_type.id and
       dr_specimen.tissue_location_id = st_acquis_loc.id and
       dr_specimen.case_record_id = dr_case.id and
       dr_case.bss_id = st_bss.id and
       (instr(aliquot_time_removed, ':') = 0 or
       instr(aliquot_time_fixed, ':') = 0 or
       instr(aliquot_time_stabilized, ':') = 0 or
       instr(blood_time_draw, ':') = 0 or
       instr(blood_time_draw_inverted, ':') = 0 or
       instr(skin_time_into_medium, ':') = 0 or
       instr(brain_time_ice, ':') = 0 or
       instr(brain_time_start_removal, ':') = 0 or
       instr(brain_time_end_aliquot, ':') = 0)
 order by specimen_id
       
update dr_specimen 
   set aliquot_time_stabilized = '17:00'
 where aliquot_time_stabilized = '1700' and
       specimen_id in 
       (
       select specimen_id
         from dr_case,
              dr_specimen,
              st_acquis_type,
              st_acquis_loc,
              st_bss
        where dr_specimen.tissue_type_id = st_acquis_type.id and
              dr_specimen.tissue_location_id = st_acquis_loc.id and
              dr_specimen.case_record_id = dr_case.id and
              dr_case.bss_id = st_bss.id and
              (instr(aliquot_time_removed, ':') = 0 or
              instr(aliquot_time_fixed, ':') = 0 or
              instr(aliquot_time_stabilized, ':') = 0 or
              instr(blood_time_draw, ':') = 0 or
              instr(blood_time_draw_inverted, ':') = 0 or
              instr(skin_time_into_medium, ':') = 0 or
              instr(brain_time_ice, ':') = 0 or
              instr(brain_time_start_removal, ':') = 0 or
              instr(brain_time_end_aliquot, ':') = 0)
        )
commit;
