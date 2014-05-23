select distinct case_id, is_eligible
  from dr_case       c,
       dr_candidate  cand,
       dr_specimen   spec
 where cand.case_record_id = c.id and
       spec.case_record_id = c.id and
       cand.is_eligible = 0
 order by case_id
