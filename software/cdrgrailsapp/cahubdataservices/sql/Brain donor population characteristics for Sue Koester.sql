select c.case_id,
       demo.AGE_FOR_INDEX,
       coll_type.code as coll_type,
       circ.date_time_actual_death, circ.date_time_presumed_death, circ.date_time_last_seen_alive, circ.date_time_pronounced_dead, 
       trf.collection_date, trf.collection_start_time, trf.cross_clamp_time,
       decode(circ.date_time_actual_death, null, 
         decode(circ.date_time_pronounced_dead, null, 
           decode(circ.date_time_presumed_death, null, circ.date_time_last_seen_alive), 
                circ.date_time_pronounced_dead),
              circ.date_time_actual_death) as calc_death,
       to_date( (to_char(trf.collection_date, 'DD-MON-YYYY') ||' '||trf.cross_clamp_time), 'DD-MON-YYYY HH24:MI' ) as xclamp_dt,
       to_date( (to_char(trf.collection_date, 'DD-MON-YYYY') ||' '||trf.collection_start_time), 'DD-MON-YYYY HH24:MI' ) as coll_start_time,
       NumToDSInterval( ((to_date( (to_char(trf.collection_date, 'DD-MON-YYYY') ||' '||trf.collection_start_time), 'DD-MON-YYYY HH24:MI' )) - 
         (decode(circ.date_time_actual_death, null, 
           decode(circ.date_time_presumed_death, null, 
             decode(circ.date_time_last_seen_alive, null, circ.date_time_pronounced_dead), 
                  circ.date_time_presumed_death),
                circ.date_time_actual_death))), 'DAY' ) as PMI,
       decode(immediate_cause, 'Other', other_immediate,   immediate_cause) as immediate_cause,
       decode(first_cause,     'Other', other_first_cause, first_cause)     as first_cause,
       decode(last_cause,      'Other', other_last_cause,  last_cause)      as last_cause
  from gtex_crf                crf,
       gtex_tissue_recovery    trf,
       gtex_crf_death_circ     circ,
       gtex_crf_demographics   demo,
       dr_case                 c,
       st_case_collection_type coll_type
 where crf.case_record_id  = c.id           and
       crf.death_circumstances_id = circ.id and
       crf.demographics_id = demo.id        and
       trf.case_record_id = c.id            and
       c.case_collection_type_id = coll_type.id and
       c.id in 
       (select spec.case_record_id
          from dr_specimen spec
         where spec.tissue_type_id in 
         (select id
            from st_acquis_type tissue
           where tissue.code = 'BRAIN')
       )
 order by c.case_id


select decode(immediate_cause, 'Other', other_immediate,   immediate_cause) as immediate_cause,
       count(*) as frequency
  from gtex_crf                crf,
       gtex_tissue_recovery    trf,
       gtex_crf_death_circ     circ,
       dr_case                 c,
       st_case_collection_type coll_type
 where crf.case_record_id  = c.id           and
       crf.death_circumstances_id = circ.id and
       trf.case_record_id = c.id            and
       c.case_collection_type_id = coll_type.id and
       c.id in 
       (select spec.case_record_id
          from dr_specimen spec
         where spec.tissue_type_id in 
         (select id
            from st_acquis_type tissue
           where tissue.code = 'BRAIN')
       )
 group by decode(immediate_cause, 'Other', other_immediate,   immediate_cause)
 order by count(*) desc

select decode(first_cause,     'Other', other_first_cause, first_cause)     as first_cause,
       count(*) as frequency
  from gtex_crf                crf,
       gtex_tissue_recovery    trf,
       gtex_crf_death_circ     circ,
       dr_case                 c,
       st_case_collection_type coll_type
 where crf.case_record_id  = c.id           and
       crf.death_circumstances_id = circ.id and
       trf.case_record_id = c.id            and
       c.case_collection_type_id = coll_type.id and
       c.id in 
       (select spec.case_record_id
          from dr_specimen spec
         where spec.tissue_type_id in 
         (select id
            from st_acquis_type tissue
           where tissue.code = 'BRAIN')
       )
 group by decode(first_cause,     'Other', other_first_cause, first_cause)
 order by count(*) desc
       
select case_id, 
  from gtex_crf                crf,
       gtex_crf_demographics   demo,
       dr_case                 c
 where crf.case_record_id  = c.id           and
       crf.demographics_id = demo.id        and
       c.id in 
       (select spec.case_record_id
          from dr_specimen spec
         where spec.tissue_type_id in 
         (select id
            from st_acquis_type tissue
           where tissue.code = 'BRAIN')
       )
 order by c.case_id

select lspec.tissue_site_detail, avg(LatestRin_ldacc_tissue_id(lspec.id))
  from dr_case                 c,
       dr_specimen             spec,
       ldacc_specimen          lspec
 where spec.case_record_id = c.id           and
       lspec.specimen_record_id = spec.id   and
       LatestRin_ldacc_tissue_id(lspec.id) != 99999 and
       c.id in 
       (select spec.case_record_id
          from dr_specimen spec
         where spec.tissue_type_id in 
         (select id
            from st_acquis_type tissue
           where tissue.code = 'BRAIN')
       )
 group by lspec.tissue_site_detail
