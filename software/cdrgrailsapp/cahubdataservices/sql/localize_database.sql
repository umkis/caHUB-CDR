delete from user_login where username='ldaccservice';

commit;

update st_appsetting set value = 0 where code = 'LDACC_IMPORT_ON_OFF';

update st_appsetting set value = 'taborde@mail.nih.gov' where code = 'RECALL_CDR_CONTACT';

update st_appsetting set value = 'taborde@mail.nih.gov' where code = 'RECALL_CBR_CONTACT';

update st_appsetting set value = 'taborde@mail.nih.gov' where code = 'RECALL_PRC_CONTACT';

update st_appsetting set value = 'taborde@mail.nih.gov' where code = 'RECALL_LDACC_CONTACT';

update st_appsetting set value = 'taborde@mail.nih.gov' where code = 'RECALL_BRAINBANK_CONTACT';

update st_appsetting set value = 'taborde@mail.nih.gov' where code = 'RECALL_ADMIN_CONTACT';

update st_appsetting set value = 'taborde@mail.nih.gov' where code = 'RECALL_APR_CONTACT';

update st_appsetting set value = 'taborde@mail.nih.gov' where code = 'PASSWORD_EXPIRE_ALERT_RECIPIENT';

update st_appsetting set BIG_value = 'taborde@mail.nih.gov' where code = 'BPV_CASE_CREATION_DISTRO';

update st_appsetting set BIG_value = 'taborde@mail.nih.gov' where code = 'BPV_INFECTIOUS_DATA_DISTRO';

update st_appsetting set BIG_value = 'taborde@mail.nih.gov' where code = 'PRC_REPORT_AVAILABLE_DISTRO';

update st_appsetting set BIG_value = 'taborde@mail.nih.gov' where code = 'PRC_REPORT_FLAGGED_QC_DISTRO';

update st_appsetting set value = 'taborde@mail.nih.gov' where code = 'PRC_REPORT_FLAGGED_QC_DISTRO';

update st_appsetting set value = 'taborde@mail.nih.gov' where code = 'LDACC_IMPORT_EMAIL';

update st_appsetting set value = 'taborde@mail.nih.gov' where code = 'REST_SERVICE_EMAIL';

update st_appsetting set value = 'taborde@mail.nih.gov' where code = 'REST_SERVICE_EMAIL';

update st_appsetting set value = 'taborde@mail.nih.gov' where code = 'FILE_UPLOAD_ALERT_EMAIL';

update st_appsetting set value = 'http://' where code = 'CDR_PROTOCOL';

update st_appsetting set value = 'nci-S076378-l.nci.nih.gov:8080' where code = 'CDR_HOST';

update st_appsetting set value = 'http://' where code = 'CDR_PROTOCOL';

update st_appsetting set value = 'http://nci-S076378-l.nci.nih.gov:8081' where code = 'CDRAR_HOSTNAME';

update st_appsetting set BIG_value = 'taborde@mail.nih.gov' where code = 'PRC_ACTIVITY_DISTRO';

update st_appsetting set BIG_value = 'taborde@mail.nih.gov' where code = 'CASE_STATUS_CHANGE_DISTRO';

update st_appsetting set BIG_value = 'taborde@mail.nih.gov' where code = 'SHIPPING_EVENT_DISTRO';

update st_appsetting set BIG_value = 'taborde@mail.nih.gov' where code = 'COLLECTION_EVENT_DISTRO';

update st_appsetting set BIG_value = 'taborde@mail.nih.gov' where code = 'APERIO_IMAGE_DISTRO';

update st_appsetting set BIG_value = 'taborde@mail.nih.gov' where code = 'DM_FAST_TRACK_DISTRO';

update st_appsetting set BIG_value = 'taborde@mail.nih.gov' where code = 'LDACC_RIN_DISTRO';

update st_appsetting set BIG_value = 'taborde@mail.nih.gov' where code = 'FILE_UPLOAD_DISTRO';

update st_appsetting set BIG_value = 'taborde@mail.nih.gov' where code = 'LDACC_RIN_DISTRO';

COMMIT;


