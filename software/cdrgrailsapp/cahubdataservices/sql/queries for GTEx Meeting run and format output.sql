COLUMN BSS FORMAT A20
COLUMN COLL_TYPE FORMAT A20
COLUMN AGE_BUCKET FORMAT A20
COLUMN GENDER FORMAT A20
COLUMN RACE FORMAT A32
COLUMN ETHNICITY FORMAT A30
COLUMN HARDY_SCALE FORMAT A20
COLUMN CONSENTED FORMAT A20
COLUMN ELIGIBLE FORMAT A20
COLUMN TISSUE FORMAT A25

spool "H:\My Documents\CDR\Data Analysis\GTEx-Meeting.11-Dec-2012.log"

select decode(cand.is_consented,0,'No',1,'Yes') as Consented,
       decode(cand.is_eligible ,0,'No',1,'Yes') as Eligible, count(*) as frequency
  from dr_candidate          cand,
       dr_case               case
 where cand.case_record_id = case.id
 group by cand.is_consented, cand.is_eligible
 order by cand.is_consented desc, cand.is_eligible desc;

/* Donor Accrual */
select '=============== Donor Accrual ===============' as donor_accrual from dual;
select coll_type.code as coll_type, count(*) as frequency
  from gtex_crf_demographics demo,
       gtex_crf              crf,
       dr_case               case,
       gtex_crf_death_circ   death,
       dr_candidate          cand,
       st_case_collection_type coll_type
 where demo.id = crf.demographics_id         and
       crf.case_record_id = case.id          and
       crf.death_circumstances_id = death.id and
       case.case_collection_type_id = coll_type.id and
       cand.case_record_id = case.id  
 group by coll_type.code
 order by coll_type.code;

/* Accrual by Month for Postmortem and OPO */
select '=============== PM/OPO Accrual by Month ===============' as donor_accrual_by_month from dual;
select to_char(collection_date,'MON-YYYY') as collection_month, count(*) as frequency
  from dr_case              case,
       gtex_tissue_recovery trf,
       st_case_collection_type coll_type
 where trf.case_record_id = case.id           and
       case.case_collection_type_id = coll_type.id and
       coll_type.code in ('POSTM','OPO')
 group by to_char(collection_date,'MON-YYYY')
 order by to_date(to_char(collection_date,'MON-YYYY'),'MON-YYYY');

/* Accrual by Month for Surgical Collections */
select '=============== SURGICAL Accrual by Month ===============' as surgical_accrual_by_month from dual;
select to_char(collection_date,'MON-YYYY') as collection_month, count(*) as frequency
  from dr_case              case,
       gtex_tissue_recovery trf,
       st_case_collection_type coll_type
 where trf.case_record_id = case.id           and
       case.case_collection_type_id = coll_type.id and
       coll_type.code in ('SURGI')
 group by to_char(collection_date,'MON-YYYY')
 order by to_date(to_char(collection_date,'MON-YYYY'),'MON-YYYY');

/* GTEx Eligibility Criteria */
select '=============== GTEx Eligibility Criteria ===============' as gtex_eligibility from dual;
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
  from gtex_donor_eligibility elig,
       dr_candidate cand,
       st_case_collection_type coll_type,
       st_bss bss
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


/* Eligible Cases by Age and Collection Type */
select '============ Eligible Cases by Age and Collection Type ===========' as donor_by_age_coll_type from dual;
select case
         when (age_for_index >= 21) and (age_for_index <= 30) then '21 - 30'
         when (age_for_index >= 31) and (age_for_index <= 40) then '31 - 40'
         when (age_for_index >= 41) and (age_for_index <= 50) then '41 - 50'
         when (age_for_index >= 51) and (age_for_index <= 60) then '51 - 60'
         when (age_for_index >= 61) and (age_for_index <= 70) then '61 - 70'
           else to_char(age_for_index)
         end as age_bucket, coll_type.code as coll_type, count(*) as frequency
  from gtex_crf_demographics demo,
       gtex_crf              crf,
       dr_case               case,
       gtex_crf_death_circ   death,
       dr_candidate          cand,
       st_case_collection_type coll_type
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

         
/* Donors by Gender and Collection Type */
select '============ Donors by Sex and Collection Type ===========' as donor_by_sex_coll_type from dual;
select gender, coll_type.code as coll_type, count(*) as frequency
  from gtex_crf_demographics demo,
       gtex_crf              crf,
       dr_case               case,
       gtex_crf_death_circ   death,
       dr_candidate          cand,
       st_case_collection_type coll_type
 where demo.id = crf.demographics_id         and
       crf.case_record_id = case.id          and
       crf.death_circumstances_id = death.id and
       case.case_collection_type_id = coll_type.id and
       cand.case_record_id = case.id
 group by gender, coll_type.code
 order by gender, coll_type.code;
 
/* Enrollment by Race/Ethnicity */
select '============ Enrollment by Race/Ethnicity ===========' as enroll_by_race_eth_coll_type from dual;
select race, ethnicity, count(*) as frequency
  from gtex_crf_demographics demo,
       gtex_crf              crf,
       dr_case               case,
       gtex_crf_death_circ   death,
       dr_candidate          cand,
       st_case_collection_type coll_type
 where demo.id = crf.demographics_id         and
       crf.case_record_id = case.id          and
       crf.death_circumstances_id = death.id and
       case.case_collection_type_id = coll_type.id and
       cand.is_eligible = 1                  and
       coll_type.code in ('POSTM','OPO')     and
       cand.case_record_id = case.id
 group by race, ethnicity 
 order by race, ethnicity ;

/* Tissue Count by Tissue Type */
select '============ Tissue Count by Tissue Type ===========' as Tissue_Count_by_Tissue_Type from dual;
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

/* Tissue Count by Collection Type */
select '============ Tissue Count by Collection Type ===========' as Tissue_Count_by_Coll_Type from dual;
select tissue, coll_type, count(*) as frequency
  from (
  select distinct case_id, t.name as tissue, coll.code as coll_type 
    from dr_case c, 
         dr_specimen s, 
         st_case_collection_type coll,
         st_acquis_type t,
         st_study sd 
   where c.id = s.case_record_id and 
         c.case_collection_type_id = coll.id       and 
         s.tissue_type_id = t.id and 
         c.study_id = sd.id      and 
         sd.code='GTEX' ) 
 group by tissue, coll_type;
 
/* Hardy scale by collection_type */
select '========= Hardy scale by collection_type ==========' as hardy_scale_by_coll_type from dual;
select hardy_scale, coll_type.code as coll_type,
       count(*) as frequency
  from gtex_crf_demographics demo,
       gtex_crf              crf,
       dr_case               case,
       gtex_crf_death_circ   death,
       dr_candidate          cand,
       st_case_collection_type coll_type
 where demo.id = crf.demographics_id         and
       crf.case_record_id = case.id          and
       crf.death_circumstances_id = death.id and
       case.case_collection_type_id = coll_type.id and
       coll_type.code in ('POSTM','OPO', 'SURGI')     and
       cand.case_record_id = case.id
 group by hardy_scale, coll_type.code
 order by hardy_scale, coll_type.code;


/* Average RIN by Hardy Scale */

/* Mean RIN/donor */
select '========== Mean RIN/donor ============' as mean_rin_per_donor from dual;
select avg(avg_rin) from
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
     from dr_case               case,
          dr_specimen           spec,
          ldacc_specimen        lspec,
          ldacc_qc              qc,
          ldacc_qc_result       result,
          st_case_collection_type coll_type
    where case.case_collection_type_id = coll_type.id and
          coll_type.code in ('POSTM','OPO')     and
          spec.case_record_id = case.id         and
          qc.specimen_id = lspec.id             and
          lspec.specimen_record_id = spec.id    and
          result.qc_id = qc.id                  and
          result.attribute = 'RIN Number')
  group by case_id) a,
  gtex_crf  crf,
  dr_case   case,
  gtex_crf_death_circ   death
 where a.case_id =  case.case_id and
       crf.case_record_id = case.id and
       crf.death_circumstances_id = death.id;
       
/* Snapshot of average RINs */
select '========== Snapshot of average RINs ===========' as snapshot_avg_rin from dual;
select case
         when round(avg_rin,0) < 5 then '0-4'
         when round(avg_rin,0) = 5 then '5'
         when round(avg_rin,0) = 6 then '6'
         when round(avg_rin,0) > 6 then '>6'
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
     from dr_case               case,
          dr_specimen           spec,
          ldacc_specimen        lspec,
          ldacc_qc              qc,
          ldacc_qc_result       result,
          st_case_collection_type coll_type
    where case.case_collection_type_id = coll_type.id and
          coll_type.code in ('POSTM','OPO')     and
          spec.case_record_id = case.id         and
          qc.specimen_id = lspec.id             and
          lspec.specimen_record_id = spec.id    and
          result.qc_id = qc.id                  and
          result.attribute = 'RIN Number')
  group by case_id)
  group by case
         when round(avg_rin,0) < 5 then '0-4'
         when round(avg_rin,0) = 5 then '5'
         when round(avg_rin,0) = 6 then '6'
         when round(avg_rin,0) > 6 then '>6'
       else
         to_char(avg_rin)
       end ;

/* Average RIN by age */

spool off
-- separate columns with a comma
set colsep ,     
-- only one header row
set pagesize 0   
-- remove trailing blanks
set trimspool on 
-- this may or may not be useful...depends on your headings.
set headsep off  
-- X should be the sum of the column widths
set linesize 60   
-- X should be the length you want for numbers (avoid scientific notation on IDs)
set numw 15       
COLUMN case_id FORMAT A20
COLUMN HARDY_SCALE FORMAT A20
COLUMN AGE FORMAT A20
COLUMN BMI FORMAT A20

spool "H:\My Documents\CDR\Data Analysis\GTEx-Meeting.11-Dec-2012.csv"

select '========== Average RIN by Hardy Scale ============' as avg_rin_by_hardy_scale from dual;
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
       from dr_specimen           spec,
            ldacc_specimen        lspec,
            ldacc_qc              qc,
            ldacc_qc_result       result
      where qc.specimen_id = lspec.id             and
            lspec.specimen_record_id = spec.id    and
            result.qc_id = qc.id                  and
            result.attribute = 'RIN Number'
   group by spec.specimen_id) subq,
         dr_specimen       spec,
         dr_case           c
   where subq.specimen_id = spec.specimen_id  and
         spec.case_record_id = c.id
   group by c.case_id)         a,
       gtex_crf                crf,
       dr_case                 case,
       gtex_crf_death_circ     death,
       st_case_collection_type coll_type
 where a.case_id =  case.case_id              and
       crf.case_record_id = case.id           and
       crf.death_circumstances_id = death.id  and
       case.case_collection_type_id = coll_type.id and
       coll_type.code in ('POSTM','OPO');

select '========== Average RIN by age ===========' as avg_rin_by_age from dual;
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
       from dr_specimen           spec,
            ldacc_specimen        lspec,
            ldacc_qc              qc,
            ldacc_qc_result       result
      where qc.specimen_id = lspec.id             and
            lspec.specimen_record_id = spec.id    and
            result.qc_id = qc.id                  and
            result.attribute = 'RIN Number'
   group by spec.specimen_id) subq,
         dr_specimen       spec,
         dr_case           c
   where subq.specimen_id = spec.specimen_id  and
         spec.case_record_id = c.id
   group by c.case_id)         a,
       gtex_crf                crf,
       dr_case                 case,
       gtex_crf_demographics   demo,
       st_case_collection_type coll_type
 where a.case_id =  case.case_id              and
       crf.case_record_id = case.id           and
       crf.demographics_id = demo.id          and
       case.case_collection_type_id = coll_type.id and
       coll_type.code in ('POSTM','OPO');

/* Average RIN by BMI */
select '========== Average RIN by BMI ===========' as avg_rin_by_bmi from dual;
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
       from dr_specimen           spec,
            ldacc_specimen        lspec,
            ldacc_qc              qc,
            ldacc_qc_result       result
      where qc.specimen_id = lspec.id             and
            lspec.specimen_record_id = spec.id    and
            result.qc_id = qc.id                  and
            result.attribute = 'RIN Number'
   group by spec.specimen_id) subq,
         dr_specimen       spec,
         dr_case           c
   where subq.specimen_id = spec.specimen_id  and
         spec.case_record_id = c.id
   group by c.case_id)         a,
       gtex_crf                crf,
       dr_case                 case,
       gtex_crf_demographics   demo,
       st_case_collection_type coll_type
 where a.case_id =  case.case_id              and
       crf.case_record_id = case.id           and
       crf.demographics_id = demo.id          and
       case.case_collection_type_id = coll_type.id and
       coll_type.code in ('POSTM','OPO');

select '========== Average RIN by Tissue Type ===========' as avg_rin_by_tissue from dual;
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
     from dr_case               case,
          dr_specimen           spec,
          ldacc_specimen        lspec,
          ldacc_qc              qc,
          ldacc_qc_result       result,
          st_acquis_type        tissue,
          st_case_collection_type coll_type
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
