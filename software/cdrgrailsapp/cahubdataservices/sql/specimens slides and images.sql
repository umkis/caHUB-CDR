select specimen_id, slide_id, image_id
  from dr_specimen  spec,
       dr_slide     slide,
       dr_image     image
 where image.slide_record_id = slide.id  and
       slide.specimen_record_id = spec.id and
       spec.specimen_id like 'BMS-030%'
 order by specimen_id
 
  
select id, version, date_created, internal_comments, internalguid, last_updated, public_comments, public_version, reorder_other_comment, reorder_reason, 
       reorder_request_date, reorder_type, request_reorder, slide_id, slide_location_id, specimen_record_id, final_surgical_review, local_pathology_review, 
       case_id, created_by 
  from dr_slide
select id, version, date_created, image_id, internal_comments, internalguid, last_updated, public_comments, public_version, slide_record_id 
  from dr_image
