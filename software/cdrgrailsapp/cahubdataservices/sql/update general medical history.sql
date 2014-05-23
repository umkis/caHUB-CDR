select id, version, choose_option, date_created, display_order, internal_comments, internalguid, last_updated, medical_condition, medical_history_id, medical_record, public_comments, public_version, rown, treatment, year_of_onset 
  from gtex_crf_general_medic_his
 where medical_condition like 'Liver Disease (liver abscess,%'
 
update gtex_crf_general_medic_his
   set medical_condition = 'Liver Disease (liver abscess, failure, fatty liver syndrome, inherited liver insufficiency, acute/chronic hepatic insufficiency, necrobacillosis, rupture)'
 where  medical_condition = 'Liver Disease (liver abscess, failure, fatty liver syndrome, inherited liver insufficiency, acute/chronic hepatic insufficiency, necrobacillosis, rupture,'

commit;
