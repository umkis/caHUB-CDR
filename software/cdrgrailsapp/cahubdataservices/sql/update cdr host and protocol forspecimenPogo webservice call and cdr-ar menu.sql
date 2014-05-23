select id, version, code, description, name, value, big_value from st_appsetting

UPDATE st_appsetting set value = 'http://' where code = 'CDR_PROTOCOL';
UPDATE st_appsetting set value = 'localhost:8080' where code = 'CDR_HOST'

COMMIT;
