select distinct case_id
  from dr_case       c,
       dr_specimen   spec
 where latestrin(spec.specimen_id) is not null and
       spec.case_record_id = c.id
 order by case_id;
 
select specimen_id, tissue.name, latestrin(spec.specimen_id)
  from dr_specimen     spec,
       st_acquis_type  tissue
 where spec.tissue_type_id = tissue.id and
       latestrin(spec.specimen_id) is not null;
