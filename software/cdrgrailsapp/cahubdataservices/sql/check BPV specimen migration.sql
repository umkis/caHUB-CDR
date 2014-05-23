select specimen_id, spec.tumor_status_id, fix.code, tissue.code, spec.was_consumed, spec.container_type_id, con.code
  from dr_case        c,
       dr_specimen    spec,
       st_study       study,
       st_acquis_type tissue,
       st_fixative    fix,
       st_container   con
where spec.tumor_status_id is null and
      spec.case_record_id = c.id   and
      c.study_id = study.id        and
      study.code in ('BRN','BPV')  and
      spec.tissue_type_id = tissue.id and
      spec.fixative_id = fix.id       and
      spec.container_type_id = con.id and
      substr(tissue.code,1,5) != 'BLOOD' and
      was_consumed != 1
