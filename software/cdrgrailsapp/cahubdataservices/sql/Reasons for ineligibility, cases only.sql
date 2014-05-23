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
  from cdrds.gtex_donor_eligibility  elig,                              
       cdrds.dr_candidate            cand,                              
       cdrds.st_case_collection_type coll_type,
       cdrds.st_bss                  bss,
       cdrds.dr_case                 c
 where elig.candidate_record_id = cand.id           and                              
       cand.bss_id = bss.id                         and
       cand.case_collection_type_id = coll_type.id  and
       cand.case_record_id = c.id                   
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
