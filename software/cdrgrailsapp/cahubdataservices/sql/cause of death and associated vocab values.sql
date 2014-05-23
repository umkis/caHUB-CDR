select case_id, status, manner_of_death, hardy_scale, circ.death_certificate_cause, circ.death_certificate_causev, circ.death_cert_cause_vocab_id,
       decode(immediate_cause,'Other',other_immediate,  immediate_cause) as immediate_cause,  v1.icd_cd as icd_code1,  
       decode(first_cause,    'Other',other_first_cause,first_cause)     as first_cause,      v2.icd_cd as icd_code2,
       decode(last_cause,     'Other',other_last_cause, last_cause)      as last_cause,       v3.icd_cd as icd_code3,   
       was_refrigerated, estimated_hours                            
  from cdrds.dr_case             c,                            
       cdrds.gtex_crf            crf,                            
       cdrds.gtex_crf_death_circ circ,
       cdrds.dr_cvocab           v1,
       cdrds.dr_cvocab           v2,
       cdrds.dr_cvocab           v3
 where crf.case_record_id = c.id            and                            
       crf.death_circumstances_id = circ.id and
       circ.imm_cod_cvocab_id = v1.id(+)    and
       circ.first_cod_cvocab_id = v2.id(+)  and
       circ.last_cod_cvocab_id = v3.id(+)   and
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
 order by case_id
