select tissue, count(*)
  from
(select distinct substr(spec.Specimen_ID,1,14) as tissue_id, tissue.name as tissue
  from dr_specimen    spec,
       dr_case        c,
       st_acquis_type tissue,
       st_fixative    fix
 where spec.case_record_id = c.id      and
       spec.tissue_type_id = tissue.id and
       spec.fixative_id = fix.id       and
       fix.code = 'XG' and tissue.code != 'BLOODW' and
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
 )
 group by tissue
 
