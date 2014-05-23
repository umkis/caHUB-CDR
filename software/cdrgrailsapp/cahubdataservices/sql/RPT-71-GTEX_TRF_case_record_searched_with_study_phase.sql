

select ca.case_id as caseId, 
       ( select co.name from st_case_collection_type co where ca.case_collection_type_id = co.id ) as CollType, 
       TO_CHAR(trf.collection_date, 'YYYY-MM-DD') ||', ' ||trf.collection_start_time as startTime, 
       trf.CHEST_INCISION_TIME as ChestTime, trf.CROSS_CLAMP_TIME as ClampTime, 
       to_char(trf.TEAM_LEAD_VERI_DATE, 'YYYY-MM-DD') as veriDate, 
       trf.PROSECTOR1 as prosec1, 
       trf.PROSECTOR2 as prosec2, 
       trf.PROSECTOR3 as prosec3, 
       trf.PROSECTOR4 as prosec4, 
       trf.PROSECTOR5 as prosec5, 
       trf.PROSECTOR6 as prosec6, 
       trf.PROSECTOR7 as prosec7, 
       trf.PROSECTOR8 as prosec8, 
       ph.code as phase 
from dr_case ca, gtex_tissue_recovery trf, st_studyphase ph 
where trf.case_record_id = ca.id and ca.phase_id = ph.id and ph.code = 'SU1'

