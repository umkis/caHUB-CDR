select phase.name as phase, to_char(date_created,'Mon-YYYY') as name, count(*) as frequency    
  from dr_case              c, 
       st_study             study,
       st_bss               bss,
       st_bss               parent_bss,
       st_studyphase        phase
 where c.study_id = study.id       and
       study.code = 'GTEX'         and
       c.bss_id = bss.id                  and
       bss.parent_bss_id = parent_bss.id  and
       c.phase_id = phase.id              and
       (parent_bss.code = 'RPCI' or parent_bss.code = 'NDRI')
 group by phase.name, to_char(date_created,'Mon-YYYY')                               
 order by to_date(to_char(date_created,'Mon-YYYY'),'Mon-YYYY')          

select * from st_bss

select * from st_studyphase

select c.case_id, phase.name as phase, to_char(date_created,'Mon-YYYY') as name
  from dr_case              c, 
       st_study             study,
       st_bss               bss,
       st_bss               parent_bss,
       st_studyphase        phase
 where c.study_id = study.id       and
       study.code = 'GTEX'         and
       c.bss_id = bss.id                  and
       bss.parent_bss_id = parent_bss.id  and
       c.phase_id = phase.id              and
       (parent_bss.code = 'RPCI' or parent_bss.code = 'NDRI')
 and   (phase.name = 'Pilot Phase' and ((to_char(date_created,'Mon-YYYY')='Apr-2013') or (to_char(date_created,'Mon-YYYY')='May-2013')))
