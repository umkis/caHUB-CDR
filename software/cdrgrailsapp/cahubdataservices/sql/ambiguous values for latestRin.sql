select case_id, subq.specimen_id, lspec.material_type, lspec.tissue_site, lspec.tissue_site_detail, latest_rin, lq.date_run, lr.attribute, lr.value
  from
  (
  select case_id, spec.specimen_id, latestRin(spec.specimen_id) as latest_rin
    from dr_specimen     spec,
         dr_case         c,
         st_study        study,
         st_acquis_type  tissue
   where c.study_id = study.id       and
         spec.case_record_id = c.id  and
         spec.tissue_type_id = tissue.id and
         latestRin(spec.specimen_id) = '*****' 
   ) subq,
   ldacc_specimen  lspec,
   ldacc_qc        lq,
   ldacc_qc_result lr    
 where subq.specimen_id = lspec.private_id and
       lq.specimen_id = lspec.id           and
       lr.qc_id = lq.id
 order by subq.specimen_id, date_run
