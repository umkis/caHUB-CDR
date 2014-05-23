select bss.code as bss, /* candidate_id, */ 
       tissue.name as primary_tissue,
       c.case_id,
       to_char(c.date_created, 'DD-MON-YYYY') as date_created,
       /* decode(is_consented, 1, 'Yes', 0, 'No') as is_consented,
       decode(is_eligible, 1, 'Yes', 0, 'No') as is_eligible, */
       /* study.code as study, bpvse.meet_criteria, reason_not_meet, other_reason_not_meet, */
       status.name as case_status,
       bpvb.blood_minimum,
       bpvtge.excess_released,
       case
         when bpvtge.excess_released='No' then null
         else bpvws.parent_sample_id
         end
       as conditional_parent_sample_id,
       bpvws.parent_sample_id
  from cdrds.dr_case                  c,
       cdrds.st_study                 study,
       cdrds.st_case_status           status,
       cdrds.st_bss                   bss,
       cdrds.st_acquis_type           tissue,
       cdrds.bpv_blood_form           bpvb,
       cdrds.bpv_work_sheet           bpvws,
       cdrds.bpv_tissue_gross_evaluation bpvtge
 where bpvb.case_record_id(+)  = c.id                  and
       c.case_status_id = status.id                    and
       bpvws.case_record_id(+) = c.id                  and
       bpvtge.case_record_id(+) = c.id                 and
       c.study_id = study.id                           and
       c.bss_id = bss.id                               and
       c.primary_tissue_type_id = tissue.id            and
       study.code in ('BPV', 'BRN')
 order by case_id
