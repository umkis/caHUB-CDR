
select to_char(date_created,'Mon-YYYY') as name, count(*) as frequency  
  from dr_case              case,
       st_study             study      
 where case.study_id = study.id     and
       study.code = 'GTEX'
 group by to_char(date_created,'Mon-YYYY')                     
 order by to_date(to_char(date_created,'Mon-YYYY'),'Mon-YYYY')
 
