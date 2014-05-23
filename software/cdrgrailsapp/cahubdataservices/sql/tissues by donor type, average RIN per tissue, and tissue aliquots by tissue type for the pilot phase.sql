/* Tissues by Donor Type */ 
select donor_type, tissue_type, count(*) as Tissues
  from (Select distinct coll_type.name as donor_type, c.case_id, tissue.name as tissue_type
          from dr_case                 c,
               dr_specimen             spec,
               st_case_collection_type coll_type,
               st_acquis_type          tissue,
               st_study                study
         where spec.case_record_id = c.id               and
               c.case_collection_type_id = coll_type.id and
               spec.tissue_type_id = tissue.id          and
               c.study_id = study.id                    and
               study.code = 'GTEX'                      and
               coll_type.code in ('POSTM','OPO')        and
               ( c.date_created < (to_date('01-SEP-2012', 'DD-MON-YYYY')) or (c.case_id in ('GTEX-000194', 'GTEX-000228', 'GTEX-000229', 'GTEX-000225', 'GTEX-000234')))
       )
 group by donor_type, tissue_type 
 order by donor_type, tissue_type

/* N for the above */
select donor_type, count(*) as N
  from
       (Select distinct coll_type.name as donor_type, c.case_id 
          from dr_case                 c,
               dr_specimen             spec,
               st_case_collection_type coll_type,
               st_acquis_type          tissue,
               st_study                study
         where spec.case_record_id = c.id               and
               c.case_collection_type_id = coll_type.id and
               spec.tissue_type_id = tissue.id          and
               c.study_id = study.id                    and
               study.code = 'GTEX'                      and
               coll_type.code in ('POSTM','OPO')        and
               ( c.date_created < (to_date('01-SEP-2012', 'DD-MON-YYYY')) or (c.case_id in ('GTEX-000194', 'GTEX-000228', 'GTEX-000229', 'GTEX-000225', 'GTEX-000234')))
       )
 group by donor_type
 order by donor_type



select tissue.name as tissue_type, avg(latestRin(Specimen_ID))
  from dr_specimen             spec,
       dr_case                 c,
       st_case_collection_type coll_type,
       st_acquis_type          tissue
 where spec.case_record_id = c.id               and
       c.case_collection_type_id = coll_type.id and
       spec.tissue_type_id = tissue.id          and
       coll_type.code in ('POSTM','OPO')        and
       ( c.date_created < (to_date('01-SEP-2012', 'DD-MON-YYYY')) or (c.case_id in ('GTEX-000194', 'GTEX-000228', 'GTEX-000229', 'GTEX-000225', 'GTEX-000234'))) and
       latestRin(Specimen_ID) != 99999
 group by tissue.name
 
select tissue_site_detail, avg(latestRin_ldacc_tissue_id(lspec.specimen_record_id))
  from ldacc_specimen          lspec,
       dr_specimen             spec,
       dr_case                 c,
       st_case_collection_type coll_type
 where lspec.specimen_record_id = spec.id      and
       latestRin_ldacc_tissue_id(lspec.specimen_record_id) != 99999 and 
       spec.case_record_id = c.id and 
       c.case_collection_type_id = coll_type.id and
       coll_type.code in ('POSTM','OPO')        and
       ( c.date_created < (to_date('01-SEP-2012', 'DD-MON-YYYY')) OR (c.case_id in ('GTEX-000194', 'GTEX-000228', 'GTEX-000229', 'GTEX-000225', 'GTEX-000234')))
 group by tissue_site_detail
 
select tissue_site_detail, avg(latestRin_ldacc_tissue_id(lspec.specimen_record_id))
  from ldacc_specimen          lspec,
       dr_specimen             spec,
       dr_case                 c,
       st_case_collection_type coll_type,
       st_study                study
 where lspec.specimen_record_id = spec.id      and
       latestRin_ldacc_tissue_id(lspec.specimen_record_id) != 99999 and 
       spec.case_record_id = c.id and 
       c.case_collection_type_id = coll_type.id and
       c.study_id = study.id                    and
       coll_type.code in ('POSTM','OPO')        and
       ( c.date_created < (to_date('01-SEP-2012', 'DD-MON-YYYY')) OR (c.case_id in ('GTEX-000194', 'GTEX-000228', 'GTEX-000229', 'GTEX-000225', 'GTEX-000234'))) and
       study.code = 'GTEX'
 group by tissue_site_detail
 
 
/* Aliquots by tissue type */
Select tissue.name as tissue_type, count(*) as Aliquots
  from dr_case                 c,
       dr_specimen             spec,
       st_case_collection_type coll_type,
       st_acquis_type          tissue,
       st_study                study
 where spec.case_record_id = c.id               and
       c.case_collection_type_id = coll_type.id and
       spec.tissue_type_id = tissue.id          and
       c.study_id = study.id                    and
       study.code = 'GTEX'                      and
       coll_type.code in ('POSTM','OPO')        and
       ( c.date_created < (to_date('01-SEP-2012', 'DD-MON-YYYY')) or (c.case_id in ('GTEX-000194', 'GTEX-000228', 'GTEX-000229', 'GTEX-000225', 'GTEX-000234')))
 group by tissue.name
