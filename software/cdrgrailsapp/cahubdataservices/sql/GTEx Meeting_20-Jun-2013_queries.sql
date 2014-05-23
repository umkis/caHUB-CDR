/*--------SQL queries used for GTEX meeting ( 06/17/2013 - 06/18/2013)--------------- */

/*-------- Average Rin By Age--------------- */
select a.case_id, age_for_index as age, avg_rin									
  from 									
  (select case_id, avg(avg_rin) as avg_rin									
    from									
    (select spec.specimen_id,									
            avg(case									
              when result.value = '9-10' then '9.5'									
              when result.value = '8-9'  then '8.5'									
              when result.value = '7-8'  then '7.5'									
              when result.value = '6-7'  then '6.5'									
              when result.value = '5-6'  then '5.5'									
              when result.value = '4-5'  then '4.5'									
              when result.value = '3-4'  then '3.5'									
              when result.value = '2-3'  then '2.5'									
              when result.value = '1-2'  then '1.5'									
            else result.value									
            end) as avg_rin									
       from cdrds.dr_specimen           spec,									
            cdrds.ldacc_specimen        lspec,									
            cdrds.ldacc_qc              qc,									
            cdrds.ldacc_qc_result       result									
      where qc.specimen_id = lspec.id             and									
            lspec.specimen_record_id = spec.id    and									
            result.qc_id = qc.id                  and									
            result.attribute = 'RIN Number'									
   group by spec.specimen_id) subq,									
         cdrds.dr_specimen       spec,									
         cdrds.dr_case           c									
   where subq.specimen_id = spec.specimen_id  and									
         spec.case_record_id = c.id									
   group by c.case_id)         a,									
       cdrds.gtex_crf                crf,									
       cdrds.dr_case                 case,									
       cdrds.gtex_crf_demographics   demo,									
       cdrds.st_case_collection_type coll_type									
 where a.case_id =  case.case_id              and									
       crf.case_record_id = case.id           and									
       crf.demographics_id = demo.id          and									
       case.case_collection_type_id = coll_type.id and									
       coll_type.code in ('POSTM','OPO');	
	   
/* ---------------Average Rin By BMI--------------------- */
select a.case_id, BMI, avg_rin from 								
  (select case_id, avg(avg_rin) as avg_rin								
    from								
    (select spec.specimen_id,								
            avg(case								
              when result.value = '9-10' then '9.5'								
              when result.value = '8-9'  then '8.5'								
              when result.value = '7-8'  then '7.5'								
              when result.value = '6-7'  then '6.5'								
              when result.value = '5-6'  then '5.5'								
              when result.value = '4-5'  then '4.5'								
              when result.value = '3-4'  then '3.5'								
              when result.value = '2-3'  then '2.5'								
              when result.value = '1-2'  then '1.5'								
            else result.value								
            end) as avg_rin								
       from cdrds.dr_specimen           spec,								
            cdrds.ldacc_specimen        lspec,								
            cdrds.ldacc_qc              qc,								
            cdrds.ldacc_qc_result       result								
      where qc.specimen_id = lspec.id             and								
            lspec.specimen_record_id = spec.id    and								
            result.qc_id = qc.id                  and								
            result.attribute = 'RIN Number'								
   group by spec.specimen_id) subq,								
         cdrds.dr_specimen       spec,								
         cdrds.dr_case           c								
   where subq.specimen_id = spec.specimen_id  and								
         spec.case_record_id = c.id								
   group by c.case_id)         a,								
       cdrds.gtex_crf                crf,								
       cdrds.dr_case                 case,								
       cdrds.gtex_crf_demographics   demo,								
       cdrds.st_case_collection_type coll_type								
 where a.case_id =  case.case_id              and								
       crf.case_record_id = case.id           and								
       crf.demographics_id = demo.id          and								
       case.case_collection_type_id = coll_type.id and								
       coll_type.code in ('POSTM','OPO');								
/* ---------------------Average RIN by Tissue Type ---------------------*/ 
   select tissue_type, avg(avg_rin) as avg_rin from										
   (select case.id, case_id, lspec.tissue_site_detail as tissue_type,										
           case										
             when result.value = '9-10' then '9.5'										
             when result.value = '8-9'  then '8.5'										
             when result.value = '7-8'  then '7.5'										
             when result.value = '6-7'  then '6.5'										
             when result.value = '5-6'  then '5.5'										
             when result.value = '4-5'  then '4.5'										
             when result.value = '3-4'  then '3.5'										
             when result.value = '2-3'  then '2.5'										
             when result.value = '1-2'  then '1.5'										
           else result.value										
           end as avg_rin										
     from cdrds.dr_case               case,										
          cdrds.dr_specimen           spec,										
          cdrds.ldacc_specimen        lspec,										
          cdrds.ldacc_qc              qc,										
          cdrds.ldacc_qc_result       result,										
          cdrds.st_acquis_type        tissue,										
          cdrds.st_case_collection_type coll_type										
    where case.case_collection_type_id = coll_type.id and										
          spec.tissue_type_id = tissue.id       and										
          coll_type.code in ('POSTM','OPO')     and										
          spec.case_record_id = case.id         and										
          qc.specimen_id = lspec.id             and										
          lspec.specimen_record_id = spec.id    and										
          result.qc_id = qc.id                  and										
          result.attribute = 'RIN Number'										
    order by case_id,  tissue.name)										
  group by tissue_type										
  order by tissue_type;										
										
spool off										
/* ---------------------Average RIN by donor/collectionType ---------------------*/
select coll_type.code, avg(avg_rin) from						
  (select case_id, avg(avg_rin) as avg_rin from						
   (select case_id,  spec.specimen_id,						
           case						
             when result.value = '9-10' then '9.5'						
             when result.value = '8-9'  then '8.5'						
             when result.value = '7-8'  then '7.5'						
             when result.value = '6-7'  then '6.5'						
             when result.value = '5-6'  then '5.5'						
             when result.value = '4-5'  then '4.5'						
             when result.value = '3-4'  then '3.5'						
             when result.value = '2-3'  then '2.5'						
             when result.value = '1-2'  then '1.5'						
           else result.value						
           end as avg_rin						
     from cdrds.dr_case               case,						
          cdrds.dr_specimen           spec,						
          cdrds.ldacc_specimen        lspec,						
          cdrds.ldacc_qc              qc,						
          cdrds.ldacc_qc_result       result,						
          cdrds.st_case_collection_type coll_type						
    where case.case_collection_type_id = coll_type.id and						
          /* coll_type.code in ('POSTM','OPO')     and */						
          spec.case_record_id = case.id         and						
          qc.specimen_id = lspec.id             and						
          lspec.specimen_record_id = spec.id    and						
          result.qc_id = qc.id                  and						
          result.attribute = 'RIN Number')						
  group by case_id,  specimen_id) a,						
  cdrds.gtex_crf  crf,						
  cdrds.dr_case   case,						
  cdrds.gtex_crf_death_circ   death,						
  cdrds.st_case_collection_type coll_type						
where a.case_id =  case.case_id and						
      crf.case_record_id = case.id and						
      crf.death_circumstances_id = death.id and						
      case.case_collection_type_id = coll_type.id						
group by coll_type.code;	
/* ---------------------Average RIN by Hardy Scale ---------------------*/
select a.case_id, hardy_scale, avg_rin 							
  from 							
  (select case_id, avg(avg_rin) as avg_rin							
    from							
    (select spec.specimen_id,							
            avg(case							
              when result.value = '9-10' then '9.5'							
              when result.value = '8-9'  then '8.5'							
              when result.value = '7-8'  then '7.5'							
              when result.value = '6-7'  then '6.5'							
              when result.value = '5-6'  then '5.5'							
              when result.value = '4-5'  then '4.5'							
              when result.value = '3-4'  then '3.5'							
              when result.value = '2-3'  then '2.5'							
              when result.value = '1-2'  then '1.5'							
            else result.value							
            end) as avg_rin							
       from cdrds.dr_specimen           spec,							
            cdrds.ldacc_specimen        lspec,							
            cdrds.ldacc_qc              qc,							
            cdrds.ldacc_qc_result       result							
      where qc.specimen_id = lspec.id             and							
            lspec.specimen_record_id = spec.id    and							
            result.qc_id = qc.id                  and							
            result.attribute = 'RIN Number'							
   group by spec.specimen_id) subq,							
         cdrds.dr_specimen       spec,							
         cdrds.dr_case           c							
   where subq.specimen_id = spec.specimen_id  and							
         spec.case_record_id = c.id							
   group by c.case_id)         a,							
       cdrds.gtex_crf                crf,							
       cdrds.dr_case                 case,							
       cdrds.gtex_crf_death_circ     death,							
       cdrds.st_case_collection_type coll_type							
 where a.case_id =  case.case_id              and							
       crf.case_record_id = case.id           and							
       crf.death_circumstances_id = death.id  and							
       case.case_collection_type_id = coll_type.id and							
       coll_type.code in ('POSTM','OPO');							
/* ---------------------Hardy Scale by collection type--------------------- */
	select hardy_scale, coll_type.code as coll_type,					
       count(*) as frequency					
  from cdrds.gtex_crf_demographics demo,					
       cdrds.gtex_crf              crf,					
       cdrds.dr_case               case,					
       cdrds.gtex_crf_death_circ   death,					
       cdrds.dr_candidate          cand,					
       cdrds.st_case_collection_type coll_type					
 where demo.id = crf.demographics_id         and					
       crf.case_record_id = case.id          and					
       crf.death_circumstances_id = death.id and					
       case.case_collection_type_id = coll_type.id and					
       coll_type.code in ('POSTM','OPO', 'SURGI')     and					
       cand.case_record_id = case.id					
 group by hardy_scale, coll_type.code					
 order by hardy_scale, coll_type.code;					


/* --------------Average RIN and frequency ------------------*/
select case							
          when avg_rin between 0 and 1 then '0-1'							
         when avg_rin between 1 and 2 then '1-2'							
         when avg_rin between 2 and 3 then '2-3'							
        when avg_rin between 3 and 4 then '3-4'							
         when avg_rin between 4 and 5 then '4-5'							
        when avg_rin between 5 and 6 then '5-6'							
         when avg_rin between 6 and 7 then '6-7'							
         when avg_rin between 7 and 8 then '7-8'							
         when avg_rin between 8 and 9 then '8-9'							
         when avg_rin between 9 and 10 then '8-9'							
       else							
         to_char(avg_rin)							
       end as avg_rin, count(*) as frequency							
  from							
(select case_id, avg(avg_rin) as avg_rin from							
   (select case.id, case_id,  							
           case							
             when result.value = '9-10' then '9.5'							
             when result.value = '8-9'  then '8.5'							
             when result.value = '7-8'  then '7.5'							
             when result.value = '6-7'  then '6.5'							
             when result.value = '5-6'  then '5.5'							
             when result.value = '4-5'  then '4.5'							
             when result.value = '3-4'  then '3.5'							
             when result.value = '2-3'  then '2.5'							
             when result.value = '1-2'  then '1.5'							
           else result.value							
           end as avg_rin							
     from cdrds.dr_case               case,							
          cdrds.dr_specimen           spec,							
          cdrds.ldacc_specimen        lspec,							
          cdrds.ldacc_qc              qc,							
          cdrds.ldacc_qc_result       result,							
          cdrds.st_case_collection_type coll_type							
    where case.case_collection_type_id = coll_type.id and							
          coll_type.code in ('POSTM','OPO')     and							
          spec.case_record_id = case.id         and							
          qc.specimen_id = lspec.id             and							
          lspec.specimen_record_id = spec.id    and							
          result.qc_id = qc.id                  and							
          result.attribute = 'RIN Number')							
  group by case_id)							
  group by case							
         when avg_rin between 0 and 1 then '0-1'							
         when avg_rin between 1 and 2 then '1-2'							
         when avg_rin between 2 and 3 then '2-3'							
        when avg_rin between 3 and 4 then '3-4'							
         when avg_rin between 4 and 5 then '4-5'							
        when avg_rin between 5 and 6 then '5-6'							
         when avg_rin between 6 and 7 then '6-7'							
         when avg_rin between 7 and 8 then '7-8'							
         when avg_rin between 8 and 9 then '8-9'							
         when avg_rin between 9 and 10 then '8-9'							
              else							
         to_char(avg_rin)							
       							
       end ;							
/* -----------------Case_IDS and RINS --------------------*/
  select   					
         case_id,avg_rin          					
  from            					
(select case_id, avg(avg_rin) as avg_rin from            					
   (select case.id, case_id,              					
           case            					
             when result.value = '9-10' then '9.5'            					
             when result.value = '8-9'  then '8.5'            					
             when result.value = '7-8'  then '7.5'            					
             when result.value = '6-7'  then '6.5'            					
             when result.value = '5-6'  then '5.5'            					
             when result.value = '4-5'  then '4.5'            					
             when result.value = '3-4'  then '3.5'            					
             when result.value = '2-3'  then '2.5'            					
             when result.value = '1-2'  then '1.5'            					
           else result.value            					
           end as avg_rin            					
     from cdrds.dr_case               case,            					
          cdrds.dr_specimen           spec,            					
          cdrds.ldacc_specimen        lspec,            					
          cdrds.ldacc_qc              qc,            					
          cdrds.ldacc_qc_result       result,            					
          cdrds.st_case_collection_type coll_type            					
    where case.case_collection_type_id = coll_type.id and            					
          coll_type.code in ('POSTM','OPO')     and            					
          spec.case_record_id = case.id         and            					
          qc.specimen_id = lspec.id             and            					
          lspec.specimen_record_id = spec.id    and            					
          result.qc_id = qc.id                  and					
          result.attribute = 'RIN Number')					
  group by case_id)					
  order by case_id, avg_rin					
  					
 /* ------------Case_IDS and RINS greater > 6 ---------------------*/
     select distinct case_id, count(*) from							
     (select case_id, avg(avg_rin)	as avg_rin from						
 ( select case_id, lspec.tissue_site_detail as tissue_type,							
            case							
             when result.value = '9-10' then '9.5'							
             when result.value = '8-9'  then '8.5'							
             when result.value = '7-8'  then '7.5'							
             when result.value = '6-7'  then '6.5'							
             when result.value = '5-6'  then '5.5'							
             when result.value = '4-5'  then '4.5'							
             when result.value = '3-4'  then '3.5'							
             when result.value = '2-3'  then '2.5'							
             when result.value = '1-2'  then '1.5'							
           else result.value							
           end as avg_rin							
							
     from cdrds.dr_case               case,							
          cdrds.dr_specimen           spec,							
          cdrds.ldacc_specimen        lspec,							
          cdrds.ldacc_qc              qc,							
          cdrds.ldacc_qc_result       result,							
          cdrds.st_acquis_type        tissue,							
          cdrds.st_case_collection_type coll_type							
    where case.case_collection_type_id = coll_type.id and							
          spec.tissue_type_id = tissue.id       and							
          coll_type.code in ('POSTM','OPO')     and							
          spec.case_record_id = case.id         and							
          qc.specimen_id = lspec.id             and							
          lspec.specimen_record_id = spec.id    and							
          result.qc_id = qc.id                  and							
          result.attribute = 'RIN Number'							
          							
    order by case_id,  tissue.name		)					
    group by case_id,avg_rin							
    having avg_rin > 6							
        order by case_id)							
        group by case_id							
        having count(case_id) >= 15							
        order by case_id							
							
/* -------------Case_IDS with tissue types and average RINS greater > 6 -----------------*/
select case_id, tissue_type,avg(avg_rin)  as avg_rin from                  							
 ( select case_id, lspec.tissue_site_detail as tissue_type,							
            case        							
             when result.value = '9-10' then '9.5'        							
             when result.value = '8-9'  then '8.5'        							
             when result.value = '7-8'  then '7.5'        							
             when result.value = '6-7'  then '6.5'        							
             when result.value = '5-6'  then '5.5'        							
             when result.value = '4-5'  then '4.5'        							
             when result.value = '3-4'  then '3.5'        							
             when result.value = '2-3'  then '2.5'        							
             when result.value = '1-2'  then '1.5'        							
           else result.value        							
           end as avg_rin        							
     from cdrds.dr_case               case,                    							
          cdrds.dr_specimen           spec,                    							
          cdrds.ldacc_specimen        lspec,                    							
          cdrds.ldacc_qc              qc,                    							
          cdrds.ldacc_qc_result       result,                    							
          cdrds.st_acquis_type        tissue,                    							
          cdrds.st_case_collection_type coll_type                    							
    where case.case_collection_type_id = coll_type.id and                    							
          spec.tissue_type_id = tissue.id       and                    							
          coll_type.code in ('POSTM','OPO')     and                    							
          spec.case_record_id = case.id         and                    							
          qc.specimen_id = lspec.id             and                    							
          lspec.specimen_record_id = spec.id    and                    							
          result.qc_id = qc.id                  and                    							
          result.attribute = 'RIN Number'          							
    order by case_id,  tissue.name    )							
    group by case_id,tissue_type,avg_rin							
    having avg_rin >6							
        order by case_id,tissue_type							
/* ---------------------Cause of Death for all cases ---------------------*/
select case_id, status, manner_of_death, hardy_scale, 									
       decode(immediate_cause,'Other',other_immediate,  immediate_cause) as immediate_cause,									
       decode(immediate_cause,'Other',other_first_cause,first_cause)     as first_cause,									
       decode(last_cause,     'Other',other_last_cause, last_cause)      as last_cause,									
       was_refrigerated, estimated_hours									
  from cdrds.dr_case   c,									
       cdrds.gtex_crf  crf,									
       cdrds.gtex_crf_death_circ circ									
 where crf.case_record_id = c.id and									
       crf.death_circumstances_id = circ.id									
       order by case_id									
/* ---------------Collections by Donor Type----------------------- */
select coll_type.code as coll_type, count(*) as frequency						
  from cdrds.gtex_crf_demographics demo,						
       cdrds.gtex_crf              crf,						
       cdrds.dr_case               case,						
       cdrds.gtex_crf_death_circ   death,						
       cdrds.dr_candidate          cand,						
       cdrds.st_case_collection_type coll_type						
 where demo.id = crf.demographics_id         and						
       crf.case_record_id = case.id          and						
       crf.death_circumstances_id = death.id and						
       case.case_collection_type_id = coll_type.id and						
       cand.case_record_id = case.id  						
 group by coll_type.code						
 order by coll_type.code;						
 /*-------------- Tissue Count by Tissue Type --------------------*/
					
select tissue, count(*)											
  from (select distinct case_id, t.name as tissue, bss.name as bss 											
          from cdrds.dr_case c, 											
               cdrds.dr_specimen s, 											
               cdrds.st_bss bss, 											
               cdrds.st_acquis_type t,											
               cdrds.st_study sd 											
         where c.id = s.case_record_id and 											
               c.bss_id = bss.id and 											
               s.tissue_type_id = t.id and 											
               c.study_id = sd.id											
               and sd.code='GTEX' ) 											
 group by tissue											
 order by tissue;											
/* -----------------Tissue Count by Collection Type ----------------*/
 select tissue, coll_type, count(*)  as frequency
  from (select distinct case_id, t.name as tissue, bss.name as bss , coll_type.code as coll_type
          from cdrds.dr_case c, 
               cdrds.dr_specimen s, 
               cdrds.st_bss bss, 
               cdrds.st_acquis_type t,
               cdrds.st_study sd,
               cdrds.st_case_collection_type coll_type
         where c.id = s.case_record_id and 
               c.bss_id = bss.id and 
               s.tissue_type_id = t.id and 
               c.study_id = sd.id
                      c.case_collection_type_id = coll_type.id 
               and sd.code='GTEX') 
 group by tissue, coll_type
 order by tissue;

/* ---------------------Donors by Sex and Collection Type ---------------------*/
select gender, coll_type.code as coll_type, count(*) as frequency							
  from cdrds.gtex_crf_demographics demo,							
       cdrds.gtex_crf              crf,							
       cdrds.dr_case               case,							
       cdrds.gtex_crf_death_circ   death,							
       cdrds.dr_candidate          cand,							
       cdrds.st_case_collection_type coll_type							
 where demo.id = crf.demographics_id         and							
       crf.case_record_id = case.id          and							
       crf.death_circumstances_id = death.id and							
       case.case_collection_type_id = coll_type.id and							
       cand.case_record_id = case.id							
 group by gender, coll_type.code							
 order by gender, coll_type.code;							
							
/* ---------------------Donors by Age group ---------------------*/
select case								
         when (age_for_index >= 21) and (age_for_index <= 30) then '21 - 30'								
         when (age_for_index >= 31) and (age_for_index <= 40) then '31 - 40'								
         when (age_for_index >= 41) and (age_for_index <= 50) then '41 - 50'								
         when (age_for_index >= 51) and (age_for_index <= 60) then '51 - 60'								
         when (age_for_index >= 61) and (age_for_index <= 70) then '61 - 70'								
           else to_char(age_for_index)								
         end as age_bucket, coll_type.code as coll_type, count(*) as frequency								
  from cdrds.gtex_crf_demographics demo,								
       cdrds.gtex_crf              crf,								
       cdrds.dr_case               case,								
       cdrds.gtex_crf_death_circ   death,								
       cdrds.dr_candidate          cand,								
       cdrds.st_case_collection_type coll_type								
 where demo.id = crf.demographics_id         and								
       crf.case_record_id = case.id          and								
       crf.death_circumstances_id = death.id and								
       cand.is_eligible = 1                  and								
       case.case_collection_type_id = coll_type.id and								
       cand.case_record_id = case.id         								
 group by case								
         when (age_for_index >= 21) and (age_for_index <= 30) then '21 - 30'								
         when (age_for_index >= 31) and (age_for_index <= 40) then '31 - 40'								
         when (age_for_index >= 41) and (age_for_index <= 50) then '41 - 50'								
         when (age_for_index >= 51) and (age_for_index <= 60) then '51 - 60'								
         when (age_for_index >= 61) and (age_for_index <= 70) then '61 - 70'								
           else to_char(age_for_index)								
         end, coll_type.code								
 order by case								
         when (age_for_index >= 21) and (age_for_index <= 30) then '21 - 30'								
         when (age_for_index >= 31) and (age_for_index <= 40) then '31 - 40'								
         when (age_for_index >= 41) and (age_for_index <= 50) then '41 - 50'								
         when (age_for_index >= 51) and (age_for_index <= 60) then '51 - 60'								
         when (age_for_index >= 61) and (age_for_index <= 70) then '61 - 70'								
           else to_char(age_for_index)								
         end, coll_type.code;								
								
/* ---------------------First cause of Death ---------------------*/
select decode(first_cause,'Other',other_first_cause,first_cause)     as first_cause, count(*)								
  from cdrds.gtex_crf_death_circ								
 where first_cause is not null								
 group by decode(first_cause,'Other',other_first_cause,first_cause)								
 order by count(*) desc								
/* --------------------- Immediate cause of Death ---------------------*/
select decode(immediate_cause,'Other',other_immediate,immediate_cause)     as immediate_cause, count(*)										
  from cdrds.gtex_crf_death_circ										
 where immediate_cause is not null										
  group by decode(immediate_cause,'Other',other_immediate,  immediate_cause)										
  order by count(*) desc										
/* --------------------- Last cause of Death ---------------------*/
								
select decode(last_cause,     'Other',other_last_cause, last_cause)      as last_cause, count(*)								
  from cdrds.gtex_crf_death_circ								
  group by decode(last_cause,     'Other',other_last_cause, last_cause)								
  order by count(*) desc								
								
								
/* --------------------- OPO/PM donor enrollment by month ---------------------*/
										
											
select to_char(collection_date,'MON-YYYY') as collection_month, count(*) as frequency											
  from cdrds.dr_case              case,											
       cdrds.gtex_tissue_recovery trf,											
       cdrds.st_case_collection_type coll_type											
 where trf.case_record_id = case.id           and											
       case.case_collection_type_id = coll_type.id and											
       coll_type.code in ('POSTM','OPO')											
 group by to_char(collection_date,'MON-YYYY')											
 order by to_date(to_char(collection_date,'MON-YYYY'),'MON-YYYY');											
/* --------------------- Enrollment by Race/Ethnicity ---------------------*/
										
select race, ethnicity, count(*) as frequency										
  from cdrds.gtex_crf_demographics demo,										
       cdrds.gtex_crf              crf,										
       cdrds.dr_case               case,										
       cdrds.gtex_crf_death_circ   death,										
       cdrds.dr_candidate          cand,										
       cdrds.st_case_collection_type coll_type										
 where demo.id = crf.demographics_id         and										
       crf.case_record_id = case.id          and										
       crf.death_circumstances_id = death.id and										
       case.case_collection_type_id = coll_type.id and										
       cand.is_eligible = 1                  and										
       coll_type.code in ('POSTM','OPO')     and										
       cand.case_record_id = case.id										
 group by race, ethnicity 										
 order by race, ethnicity ;										
/* --------------------- Reasons for ineligibility ---------------------*/
select case															
         when allowed_min_organ_type = 'No' then '01.  Min Organs not avail.'															
         when age                    = 'No' then '02.  Age'															
         when BMI                    = 'No' then '03.  BMI'															
         when COLLECT_IN24H_DEATH    = 'No' then '04.  Can''t collect within 24 hours'															
         when RECEIVE_TRANSFUSION_IN48H in ('Yes','Unknown') then '05.  Transfusion (Yes or Unk.)'															
         when DIAGNOSED_METASTATIS  = 'Yes' then '06.  Metastatic Cancer'															
         when RECEIVED_CHEMO_IN2Y   = 'Yes' then '07.  Chemo in last 2 Years'															
         when DRUG_ABUSE            = 'Yes' then '08.  I/V Drug abuse'															
         when HIST_OF_SEX_WITHHIV   = 'Yes' then '09.  Sex with HIV-positive'															
         when CONTACTHIV            = 'Yes' then '10. HIV-positive contact'															
         when HIST_OF_REACTIVE_ASSAYS = 'Yes' then '11. HIV-reactive Assays'															
       else															
         'Is Eligible'															
       end as reason_for_ineligiblity, count(*) as frequency															
  from cdrds.gtex_donor_eligibility elig,															
       cdrds.dr_candidate cand,															
       cdrds.st_case_collection_type coll_type,															
       cdrds.st_bss bss															
 where elig.candidate_record_id = cand.id and															
       cand.bss_id = bss.id              and															
       cand.case_collection_type_id = coll_type.id															
 group by case															
         when allowed_min_organ_type = 'No' then '01.  Min Organs not avail.'															
         when age                    = 'No' then '02.  Age'															
         when BMI                    = 'No' then '03.  BMI'															
         when COLLECT_IN24H_DEATH    = 'No' then '04.  Can''t collect within 24 hours'															
         when RECEIVE_TRANSFUSION_IN48H in ('Yes','Unknown') then '05.  Transfusion (Yes or Unk.)'															
         when DIAGNOSED_METASTATIS  = 'Yes' then '06.  Metastatic Cancer'															
         when RECEIVED_CHEMO_IN2Y   = 'Yes' then '07.  Chemo in last 2 Years'															
         when DRUG_ABUSE            = 'Yes' then '08.  I/V Drug abuse'															
         when HIST_OF_SEX_WITHHIV   = 'Yes' then '09.  Sex with HIV-positive'															
         when CONTACTHIV            = 'Yes' then '10. HIV-positive contact'															
         when HIST_OF_REACTIVE_ASSAYS = 'Yes' then '11. HIV-reactive Assays'															
       else															
         'Is Eligible'															
       end															
 order by case															
         when allowed_min_organ_type = 'No' then '01.  Min Organs not avail.'															
         when age                    = 'No' then '02.  Age'															
         when BMI                    = 'No' then '03.  BMI'															
         when COLLECT_IN24H_DEATH    = 'No' then '04.  Can''t collect within 24 hours'															
         when RECEIVE_TRANSFUSION_IN48H in ('Yes','Unknown') then '05.  Transfusion (Yes or Unk.)'															
         when DIAGNOSED_METASTATIS  = 'Yes' then '06.  Metastatic Cancer'															
         when RECEIVED_CHEMO_IN2Y   = 'Yes' then '07.  Chemo in last 2 Years'															
         when DRUG_ABUSE            = 'Yes' then '08.  I/V Drug abuse'															
         when HIST_OF_SEX_WITHHIV   = 'Yes' then '09.  Sex with HIV-positive'															
         when CONTACTHIV            = 'Yes' then '10. HIV-positive contact'															
         when HIST_OF_REACTIVE_ASSAYS = 'Yes' then '11. HIV-reactive Assays'															
       else															
         'Is Eligible'															
       end;															
															

/* --------------------- Surgical donor enrollment by month ---------------------*/												
										
select to_char(collection_date,'MON-YYYY') as collection_month, count(*) as frequency										
  from dr_case              case,										
       gtex_tissue_recovery trf,										
       st_case_collection_type coll_type										
 where trf.case_record_id = case.id           and										
       case.case_collection_type_id = coll_type.id and										
       coll_type.code in ('SURGI')										
 group by to_char(collection_date,'MON-YYYY')										
 order by to_date(to_char(collection_date,'MON-YYYY'),'MON-YYYY');										


/* ---------------------	Average Procedure Duration by collection type ---------------------*/
Query the local specimen pogo table after importing data from production (CDR-AR report)											
														
select distinct case_id, procedureduration from specimen_pogo order by case_id asc														
select distinct case_id, procedureduration from specimen_pogo where collectiontype like 'Organ Donor (OPO)' order by case_id asc														
select distinct case_id, procedureduration from specimen_pogo where collectiontype='Postmortem' order by case_id asc														
select distinct case_id, procedureduration from specimen_pogo  where collectiontype='Surgical' order by case_id asc	

/* --------------------- Average ischemic time by collection type ---------------------*/
Query the local specimen pogo table after importing data from production (CDR-AR report)
										
select  avg(ischemictime) from specimen_pogo where collectiontype ='Postmortem' and ischemictime > 0
select case_id, collectiontype, specimenid, ischemictime from specimen_pogo where collectiontype ='Postmortem' and ischemictime > 0  order by case_id asc
select  avg(ischemictime) from specimen_pogo where collectiontype like 'Organ Donor (OPO)' and ischemictime > 0
 select  avg(ischemictime) from specimen_pogo where collectiontype like 'Organ Donor (OPO)' and ischemictime !=0
select case_id, collectiontype, specimenid, ischemictime from specimen_pogo where collectiontype like 'Organ Donor (OPO)' and ischemictime > 0  order by case_id asc
select  avg(ischemictime) from specimen_pogo where collectiontype='Surgical' and ischemictime > 0
select case_id, collectiontype, specimenid, ischemictime from specimen_pogo where collectiontype='Surgical' and ischemictime > 0  order by case_id asc

select case_id, collectiontype, specimenid, ischemictime from specimen_pogo where collectiontype like 'Organ Donor (OPO)' and ischemictime < 0  order by case_id asc

		
