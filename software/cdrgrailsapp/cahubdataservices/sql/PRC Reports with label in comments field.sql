select bss.code as bss, spec.specimen_id, tissue.name as tissue_name, loc.name as tissue_loc, inv.name as inv_status, 
       prci.issue_description, prci.resolution_comments, 
       prci.pending_further_follow_up, prcs.comments as prc_specimen_comments, prcr.comments as prc_report_comments,
       prci.resolved, 
       prcs.autolysis, prcs.caption, 
       prcr.amputation_type1, prcr.amputation_type2, 
       prcr.processing, prcr.review_date, prcr.reviewed_by, prcr.staining_of_images, prcr.staining_of_slides, prcr.status
  from prc_specimen   prcs,
       dr_specimen    spec,
       dr_case        c,
       prc_issue      prci,
       st_acquis_type tissue,
       st_acquis_loc  loc,
       st_bss         bss,
       st_inventory_status inv,
       prc_report     prcr
 where prcs.specimen_record_id = spec.id    and
       prcs.inventory_status_id = inv.id    and
       prcr.case_record_id = c.id           and
       spec.case_record_id = c.id           and
       prci.specimen_record_id = spec.id    and
       prci.case_record_id = c.id           and
       spec.tissue_type_id = tissue.id      and
       spec.tissue_location_id = loc.id     and
       c.bss_id = bss.id                    and
       (
       instr ( upper (prci.issue_description), 'LABEL') != 0 or
       instr ( upper (prci.resolution_comments), 'LABEL') != 0
       )
 order by bss.code, spec.specimen_id
