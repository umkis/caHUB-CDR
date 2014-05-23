/* select status.code, status.name, autolysis, caption, comments, file_path, inventory_status_id, specimen_record_id 
  from prc_specimen        pspec,
       st_inventory_status status
 where pspec.inventory_status_id = status.id */

select bss.name, coll_type.name, spec.specimen_id, tissue.name, pspec.comments, status.code, status.name
  from prc_specimen        pspec,
       st_inventory_status status,
       st_bss              bss,
       dr_case             c,
       dr_specimen         spec,
       st_case_collection_type coll_type,
       st_acquis_type      tissue
 where pspec.inventory_status_id = status.id and
       pspec.specimen_record_id  = spec.id   and
       spec.case_record_id = c.id            and
       c.bss_id = bss.id                     and
       c.case_collection_type_id = coll_type.id and
       spec.tissue_type_id = tissue.id       and
       status.code = 'INVAL'
