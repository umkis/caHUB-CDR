
select c.case_id as CaseID, specimen_id, tissue.name as tissue, fix.name as fixative, proto.name as protocol, 
       parent_case.case_id, death_circ.opo_type, trf.collection_date, trf.collection_start_time, trf.cross_clamp_time, death_circ.date_time_pronounced_dead,
       to_date( to_char(trf.collection_date, 'MM/DD/YYYY') ||' '|| trf.collection_start_time, 'MM/DD/YYYY HH24:MI') as start_date_time,
       chp.time_in_fix, 
       trunc( mod ((chp.time_in_fix - (to_date( to_char(trf.collection_date, 'MM/DD/YYYY') ||' '|| trf.collection_start_time, 'MM/DD/YYYY HH24:MI')))* 24, 24))
       ||':'|| trunc( mod ((chp.time_in_fix - (to_date( to_char(trf.collection_date, 'MM/DD/YYYY') ||' '|| trf.collection_start_time, 'MM/DD/YYYY HH24:MI')))* 24*60, 60))
       ||':'|| trunc( mod ((chp.time_in_fix - (to_date( to_char(trf.collection_date, 'MM/DD/YYYY') ||' '|| trf.collection_start_time, 'MM/DD/YYYY HH24:MI')))* 24*60*60, 60)) as start_to_fixation,
       (chp.time_in_fix - (to_date( to_char(trf.collection_date, 'MM/DD/YYYY') ||' '|| trf.cross_clamp_time, 'MM/DD/YYYY HH24:MI'))) as clamp_to_fixation,
       trunc( mod ((chp.time_in_fix - (to_date( to_char(trf.collection_date, 'MM/DD/YYYY') ||' '|| trf.cross_clamp_time, 'MM/DD/YYYY HH24:MI')))* 24, 24))
       ||':'|| trunc( mod ((chp.time_in_fix - (to_date( to_char(trf.collection_date, 'MM/DD/YYYY') ||' '|| trf.cross_clamp_time, 'MM/DD/YYYY HH24:MI')))* 24*60, 60))
       ||':'|| trunc( mod ((chp.time_in_fix - (to_date( to_char(trf.collection_date, 'MM/DD/YYYY') ||' '|| trf.cross_clamp_time, 'MM/DD/YYYY HH24:MI')))* 24*60*60, 60)) as clamp_to_fixation_HH_MM,
       latestRin(specimen_id) 
  from dr_specimen          spec,
       dr_case              c,
       dr_case              parent_case,
       st_study             study,
       st_fixative          fix,
       st_acquis_type       tissue,
       st_protocol          proto,
       bms_tissue_recovery  bmstrf,
       dr_chp_tissue        chp,
       gtex_crf_death_circ  death_circ,
       gtex_crf             crf,
       gtex_tissue_recovery trf
 where c.study_id = study.id               and
       study.code = 'BMS'                  and
       spec.case_record_id = c.id          and
       spec.fixative_id = fix.id           and
       spec.tissue_type_id = tissue.id     and
       spec.protocol_id = proto.id         and
       /* proto.name = '1HR'                  and */
       bmstrf.case_record_id = c.id        and
       chp.specimen_record_id = spec.id    and
       c.parent_case_id = parent_case.id   and
       crf.case_record_id = parent_case.id and
       crf.death_circumstances_id = death_circ.id and
       trf.case_record_id = parent_case.id and
       latestRin(specimen_id) is not null
 order by c.case_id
