select case_id, trf.collection_date, aud_date, (aud_date - trf.collection_date) as duration
  from cdrds.dr_case                c,
       cdrds.gtex_tissue_recovery   trf,
       (
       select c.id, max(aud.date_created) as aud_date
         from cdrds.dr_case                c,
              cdrds.audit_log              aud
        where aud.persisted_object_id = c.id     and
              aud.new_value = 'BSS QA Review Complete' and
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
        group by c.id
        ) dfg
 where dfg.id = c.id               and
       trf.case_record_id = c.id   
 order by case_id

select code, name from st_case_status

select case_id, trf.collection_date, aud_date, (aud_date - trf.collection_date) as duration
  from cdrds.dr_case                c,
       cdrds.gtex_tissue_recovery   trf,
       (
       select c.id, max(aud.date_created) as aud_date
         from cdrds.dr_case                c,
              cdrds.audit_log              aud
        where aud.persisted_object_id = c.id     and
              aud.new_value = 'Data Entry Complete' and
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
        group by c.id
        ) dfg
 where dfg.id = c.id               and
       trf.case_record_id = c.id   
 order by case_id
 
 
select case_id, trf.collection_date, aud_date, (aud_date - trf.collection_date) as duration
  from cdrds.dr_case                c,
       cdrds.gtex_tissue_recovery   trf,
       (
       select c.id, max(aud.date_created) as aud_date
         from cdrds.dr_case                c,
              cdrds.audit_log              aud
        where aud.persisted_object_id = c.id     and
              aud.new_value = 'Data Entry Complete' and
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
        group by c.id
        ) dfg
 where dfg.id = c.id               and
       trf.case_record_id = c.id   and
       (aud_date - trf.collection_date) > 10
 order by case_id

select case_id, trf.collection_date, aud_date, (aud_date - trf.collection_date) as duration
  from cdrds.dr_case                c,
       cdrds.gtex_tissue_recovery   trf,
       (
       select c.id, max(aud.date_created) as aud_date
         from cdrds.dr_case                c,
              cdrds.audit_log              aud
        where aud.persisted_object_id = c.id     and
              aud.new_value = 'BSS QA Review Complete' and
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
        group by c.id
        ) dfg
 where dfg.id = c.id               and
       trf.case_record_id = c.id   and
       (aud_date - trf.collection_date) > 10
 order by case_id
