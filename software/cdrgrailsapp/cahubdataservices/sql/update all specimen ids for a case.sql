select count(*) from dr_specimen where specimen_id like 'GTEX-000478%'

update dr_specimen 
set specimen_id = replace(dr_specimen.specimen_id, 'GTEX-000478','GTEX-000479')
where specimen_id like 'GTEX-000478%'

commit;