select distinct subq1.case_id, specimen_id, inventory_status, (select name from cdrds.st_fixative where id = fixative) as fixative, tissue, location
  from 
  (
select c.case_id
  from cdrds.dr_case                 c,
       cdrds.dr_specimen             spec,
       cdrds.st_acquis_type          tissue,
       cdrds.st_acquis_loc           loc,
       cdrds.st_study                study,
       cdrds.st_case_collection_type coll_type,
       cdrds.prc_specimen            pspec,
       cdrds.st_inventory_status     status,
       cdrds.st_fixative             fix
where spec.case_record_id = c.id       and
       c.case_collection_type_id = coll_type.id and
       pspec.specimen_record_id  = spec.id   and
       pspec.inventory_status_id = status.id and
       spec.fixative_id = fix.id        and
       study.code = 'GTEX'              and
       substr(case_id, 1, 3) != 'BMS'   and
       fix.code = 'XG'                  and
       spec.tissue_type_id = tissue.id  and
       spec.tissue_location_id = loc.id and
       ( (tissue.name = 'Skin'          and loc.name like 'Leg%') OR
        (tissue.code = 'ADIPOT')                                  OR 
        (tissue.code = 'MUSCSK')                                  OR 
        (tissue.code = 'NERVTB')                                  OR
        (tissue.code = 'ARTERY')                                ) and
       c.id in 
       (select distinct case_record_id
          from cdrds.dr_specimen         spec,
               cdrds.st_acquis_type      tissue,
               cdrds.st_acquis_loc       loc,
               cdrds.prc_specimen        pspec,
               cdrds.st_inventory_status status
         where spec.tissue_type_id = tissue.id       and
               spec.tissue_location_id = loc.id      and
               pspec.specimen_record_id  = spec.id   and
               pspec.inventory_status_id = status.id and
               substr(specimen_id, 1, 3) != 'BMS'    and
               tissue.name = 'Skin'                  and
               loc.name like 'Leg%'                  and
               status.code = 'UNACC'

        UNION
        select distinct case_record_id
          from cdrds.dr_specimen         spec,
               cdrds.st_acquis_type      tissue,
               cdrds.st_acquis_loc       loc,
               cdrds.prc_specimen        pspec,
               cdrds.st_inventory_status status
         where spec.tissue_type_id = tissue.id       and
               spec.tissue_location_id = loc.id      and
               pspec.specimen_record_id  = spec.id   and
               pspec.inventory_status_id = status.id and
               substr(specimen_id, 1, 3) != 'BMS'    and
               tissue.CODE  = 'ADIPOT'               and
               status.code = 'UNACC'
         UNION 
        select distinct case_record_id
          from cdrds.dr_specimen         spec,
               cdrds.st_acquis_type      tissue,
               cdrds.st_acquis_loc       loc,
               cdrds.prc_specimen        pspec,
               cdrds.st_inventory_status status
         where spec.tissue_type_id = tissue.id       and
               spec.tissue_location_id = loc.id      and
               pspec.specimen_record_id  = spec.id   and
               pspec.inventory_status_id = status.id and
               substr(specimen_id, 1, 3) != 'BMS'    and
               tissue.CODE  = 'MUSCSK'               and
               status.code = 'UNACC'
        UNION
        select distinct case_record_id
          from cdrds.dr_specimen         spec,
               cdrds.st_acquis_type      tissue,
               cdrds.st_acquis_loc       loc,
               cdrds.prc_specimen        pspec,
               cdrds.st_inventory_status status
         where spec.tissue_type_id = tissue.id       and
               spec.tissue_location_id = loc.id      and
               pspec.specimen_record_id  = spec.id   and
               pspec.inventory_status_id = status.id and
               substr(specimen_id, 1, 3) != 'BMS'    and
               tissue.CODE  = 'NERVTB'               and
               status.code = 'UNACC'
        UNION
        select distinct case_record_id
          from cdrds.dr_specimen         spec,
               cdrds.st_acquis_type      tissue,
               cdrds.st_acquis_loc       loc,
               cdrds.prc_specimen        pspec,
               cdrds.st_inventory_status status
         where spec.tissue_type_id = tissue.id       and
               spec.tissue_location_id = loc.id      and
               pspec.specimen_record_id  = spec.id   and
               pspec.inventory_status_id = status.id and
               substr(specimen_id, 1, 3) != 'BMS'    and
               tissue.CODE  = 'ARTERY'               and
               status.code = 'UNACC'
               )
order by case_id, specimen_id
  ) subq1,
  
  (select case_id, spec.specimen_id as specimen_id, status.name as inventory_status, spec.fixative_id as fixative, tissue.name as tissue, loc.name as location
   from cdrds.dr_case                 c,
       cdrds.dr_specimen             spec,
       cdrds.st_acquis_type          tissue,
       cdrds.st_acquis_loc           loc,
       cdrds.st_study                study,
       cdrds.st_case_collection_type coll_type,
       cdrds.prc_specimen            pspec,
       cdrds.st_inventory_status     status,
       cdrds.st_fixative             fix
  where spec.case_record_id = c.id       and
       c.case_collection_type_id = coll_type.id and
       pspec.specimen_record_id  = spec.id   and
       pspec.inventory_status_id = status.id and
       spec.fixative_id = fix.id        and
       study.code = 'GTEX'              and
       substr(case_id, 1, 3) != 'BMS'   and
       fix.code = 'XG'                  and
       spec.tissue_type_id = tissue.id  and
       spec.tissue_location_id = loc.id and 
       status.code = 'UNACC'
       ) subq2
  where subq1.case_id = subq2.case_id 
  order by subq1.case_id, specimen_id