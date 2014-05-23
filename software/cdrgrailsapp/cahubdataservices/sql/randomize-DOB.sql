SELECT date_of_birth, trunc(date_of_birth, 'year') as year, (1+ABS(MOD(dbms_random.random,365.25))) as rand_Days, trunc((trunc(date_of_birth, 'year')+(1+ABS(MOD(dbms_random.random,365.25))) ),'day') as new_date
FROM gtex_crf_demographics
WHERE date_of_birth != to_date('1/1/1900', 'mm/dd/yyyy');

update gtex_crf_demographics 
SET date_of_birth = trunc((trunc(date_of_birth, 'year')+(1+ABS(MOD(dbms_random.random,365.25))) ),'day')
WHERE date_of_birth != to_date('1/1/1900', 'mm/dd/yyyy');


update bpv_consent_enrollment 
SET dob = trunc((trunc(dob, 'year')+(1+ABS(MOD(dbms_random.random,365.25))) ),'day')
WHERE dob != to_date('1/1/1900', 'mm/dd/yyyy');

update gtex_crf_death_circ 
SET date_Time_Pronounced_Dead = trunc((trunc(date_Time_Pronounced_Dead, 'year')+(1+ABS(MOD(dbms_random.random,365.25))) ),'day')
WHERE date_Time_Pronounced_Dead != to_date('1/1/1900', 'mm/dd/yyyy');


update gtex_crf_death_circ 
SET date_Time_Actual_Death = trunc((trunc(date_Time_Actual_Death, 'year')+(1+ABS(MOD(dbms_random.random,365.25))) ),'day')
WHERE date_Time_Actual_Death != to_date('1/1/1900', 'mm/dd/yyyy');


update gtex_crf_death_circ 
SET date_Time_Presumed_Death = trunc((trunc(date_Time_Presumed_Death, 'year')+(1+ABS(MOD(dbms_random.random,365.25))) ),'day')
WHERE date_Time_Presumed_Death != to_date('1/1/1900', 'mm/dd/yyyy');


commit;



