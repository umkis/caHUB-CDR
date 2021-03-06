

/* delete from st_acquis_type_st_acquis_loc; */

commit;

/* alter table st_acquis_loc drop column display_order; */



/* Renaming 'Consent Withdrawn' to 'Case Recall' in the st_case_status table */
update st_case_status set name='Case Recall' where name='Consent Withdrawn';

update st_case_status set name='Case recall in progress' where name='Withdraw consent in progress';

commit;

drop table case_withdraw_forms;

drop table case_withdraw;

/* Size change for text area fields */

alter table bpv_local_path_review MODIFY (NON_CELLULAR_DESC varchar2(4000));
alter table bpv_local_path_review MODIFY (OTHER_HISTOLOGIC_TYPE varchar2(4000));
alter table bpv_local_path_review MODIFY (SARCOMATOID_DESC varchar2(4000));
alter table bpv_local_path_review MODIFY (REASON_NOT_MEET varchar2(4000));
alter table bpv_local_path_review MODIFY (REASON_NOT_CONS varchar2(4000));
alter table bpv_prc_path_review MODIFY (NON_CELLULAR_DESC varchar2(4000));
alter table bpv_prc_path_review MODIFY (OTHER_HISTOLOGIC_TYPE varchar2(4000));
alter table bpv_prc_path_review MODIFY (SARCOMATOID_DESC varchar2(4000));
alter table bpv_prc_path_review MODIFY (REASON_NOT_MEET varchar2(4000));
alter table bpv_prc_path_review MODIFY (REASON_NOT_CONS varchar2(4000));
alter table bpv_screening_enrollment MODIFY (OTHER_REASON_NOT_MEET varchar2(4000));
alter table bpv_screening_enrollment MODIFY (OTHER_REASON varchar2(4000));
alter table bpv_tissue_gross_evaluation MODIFY (REASON_NO_PHOTO varchar2(4000));
alter table bpv_case_quality_review MODIFY (OTHER_REASON varchar2(4000));
alter table bms_tissue_recovery MODIFY (comments varchar2(4000));
alter table bpv_slide_prep MODIFY (microtome_daily_maint_os varchar2(4000));
alter table bpv_slide_prep MODIFY (waterbath_maint_os varchar2(4000));
alter table bpv_slide_prep MODIFY (he_equip_maint_os varchar2(4000));
alter table bpv_blood_form MODIFY (dna_pax_storage_issues varchar2(4000));
alter table bpv_blood_form MODIFY (rna_pax_storage_issues varchar2(4000));
alter table bpv_blood_form MODIFY (plasma_storage_issues varchar2(4000));
alter table bpv_blood_form MODIFY (serum_storage_issues varchar2(4000));
alter table bpv_clinical_data_entry MODIFY (env_carc_exp_desc varchar2(4000));
alter table bpv_clinical_data_entry MODIFY (other_add_col_risk varchar2(4000));
alter table bms_tissue_recovery MODIFY (RESTRICTION varchar2(4000));

update bpv_consent_enrollment set jewish='No' where jewish='N/A';
commit;

/* after deploying the webapp */
update dr_case set has_local_path_review = 0;
update dr_case set has_local_path_review = 1 where id in (select case_record_id from bpv_local_path_review);

commit;
