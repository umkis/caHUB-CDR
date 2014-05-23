prompt PL/SQL Developer import file
prompt Created on Friday, April 13, 2012 by taborde
set feedback off
set define off
prompt Disabling triggers for ST_PROTOCOL...
alter table ST_PROTOCOL disable all triggers;
prompt Disabling foreign key constraints for ST_PROTOCOL...
alter table ST_PROTOCOL disable constraint FK5E734EB6968C4EAF;
                              /*           FK5E734EB6968C4EAF    */
prompt Deleting ST_PROTOCOL...
delete from ST_PROTOCOL;
commit;
prompt Loading ST_PROTOCOL...
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (1, 2, 'TOP SECTION', '0-30 minutes', null, ' Top Section', '12-24 hours in fixative', 'Experiment 1', 2);
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (2, 1, 'PROTOCOL A', '0-30 minutes', null, 'Protocol A', '<6 hours in fixative', 'Experiment 1', 2);
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (3, 1, 'PROTOCOL B', '0-30 minutes', null, 'Protocol B', '6-12 hours in fixative', 'Experiment 1', 2);
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (4, 0, 'PROTOCOL C', '0-30 minutes', null, 'Protocol C', '12-24 hours in fixative', 'Experiment 1', 2);
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (5, 0, 'PROTOCOL D', '0-30 minutes', null, 'Protocol D', '72 hours in fixative', 'Experiment 1', 2);
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (6, 0, 'PROTOCOL E', '30-60 minutes', null, 'Protocol E', '<6 hours in fixative', 'Experiment 1', 2);
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (7, 0, 'PROTOCOL F', '30-60 minutes', null, 'Protocol F', '6-12 hours in fixative', 'Experiment 1', 2);
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (8, 0, 'PROTOCOL G', '30-60 minutes', null, 'Protocol G', '12-24 hours in fixative', 'Experiment 1', 2);
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (9, 0, 'PROTOCOL H', '30-60 minutes', null, 'Protocol H', '72 hours in fixative', 'Experiment 1', 2);
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (10, 0, 'PROTOCOL I', '2 hours', null, 'Protocol I', '<6 hours in fixative', 'Experiment 1', 2);
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (11, 0, 'PROTOCOL J', '2 hours', null, 'Protocol J', '6-12 hours in fixative', 'Experiment 1', 2);
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (12, 0, 'PROTOCOL K', '2 hours', null, 'Protocol K', '12-24 hours in fixative', 'Experiment 1', 2);
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (13, 0, 'PROTOCOL L', '2 hours', null, 'Protocol L', '72 hours in fixative', 'Experiment 1', 2);
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (14, 0, 'PROTOCOL M', '12+ hours', null, 'Protocol M', '<6 hours in fixative', 'Experiment 1', 2);
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (15, 0, 'PROTOCOL N', '12+ hours', null, 'Protocol N', '6-12 hours in fixative', 'Experiment 1', 2);
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (16, 0, 'PROTOCOL O', '12+ hours', null, 'Protocol O', '12-24 hours in fixative', 'Experiment 1', 2);
insert into ST_PROTOCOL (id, version, code, delay_to_fixation, description, name, time_in_fixative, study_id)
values (17, 0, 'PROTOCOL P', '12+ hours', null, 'Protocol P', '72 hours in fixative', 'Experiment 1', 2);
commit;
prompt 17 records loaded
prompt Enabling foreign key constraints for ST_PROTOCOL...
alter table ST_PROTOCOL enable constraint FK5E734EB6968C4EAF;
prompt Enabling triggers for ST_PROTOCOL...
alter table ST_PROTOCOL enable all triggers;
set feedback on
set define on
prompt Done.
