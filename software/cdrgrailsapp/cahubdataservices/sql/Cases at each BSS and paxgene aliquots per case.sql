select parent_bss.name as parent_BSS, bss.name as child_BSS, c.case_id, count(*) as paxgene_aliquots
  from dr_specimen    spec,
       st_study       study,
       dr_case        c,
       st_bss         bss,
       st_bss         parent_bss,
       st_acquis_type tissue,
       st_fixative    fix
 where spec.case_record_id = c.id and
       c.study_id = study.id      and
       study.code = 'GTEX'        and
       spec.fixative_id = fix.id  and
       fix.code = 'XG'            and
       spec.tissue_type_id = tissue.id and
       tissue.code != 'BLOODW'    and
       c.bss_id = bss.id          and
       bss.parent_bss_id = parent_bss.id and
       c.id in 
       (select distinct persisted_object_id 
          from cdrds.audit_log 
         where class_name like '%CaseRecord%'       and
               new_value = 'BSS QA Review Complete' and 
               persisted_object_id in 
               (select id 
                  from cdrds.dr_case c 
                 where c.phase_id =
                       (select id 
                          from cdrds.st_studyphase p
                         where p.code = 'SU1') 
               ) and 
               date_created < to_date('01-Mar-2014', 'DD-Mon-YYYY')
       )
 group by parent_bss.name, bss.name, c.case_id
 order by parent_bss.name, bss.name, c.case_id
