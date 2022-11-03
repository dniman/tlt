namespace :objects do
  namespace :land do
    namespace :destroy do
      task :tasks => [
        'objects:land:destination:mss_objects_app:link_param:add_hist:delete',
        'objects:land:destination:mss_objects_app:link_param:land_pl:delete',
        'objects:land:destination:mss_objects_app:link_param:obj_name_hist:delete',
        'objects:land:destination:mss_objects_app:link_param:adr_str:delete',
        'objects:land:destination:mss_objects_app:link_param:id_obj:delete',
        'objects:land:destination:mss_objects_app:link_param:usl_n:delete',
        'objects:land:destination:mss_objects_app:link_param:rn_old:delete',
        'objects:land:destination:mss_objects_app:link_param:land_ownership:delete',
        'objects:land:destination:mss_objects_app:link_param:transition_rf_ms:delete',
        'objects:land:destination:mss_objects_app:link_param:land_kateg:delete',
        'objects:land:destination:mss_objects_app:link_param:land_used:delete',
        'objects:land:destination:mss_objects_app:link_param:unmovable_used_new:delete',
        'objects:land:destination:mss_objects_app:link_param:grounds_release_release_id:delete',
        'objects:land:destination:mss_objects_app:link_param:gr_rel_groups_gr_rel_group_id:delete',
        'objects:land:destination:mss_objects_app:link_param:target_doc_target_doc_id:delete',
        'objects:land:destination:mss_objects_app:link_param:grounds_funk_using_grounds_funk_using_id:delete',
        'objects:land:destination:mss_objects_app:link_param:wow_obj:delete',
        'objects:land:destination:mss_objects_app:link_param:soc_zn_obj:delete',
        'objects:land:destination:mss_objects_app:link_param:obj_zkx:delete',
        'objects:land:destination:mss_objects_app:link_param:vid_obj_zkx:delete',
        'objects:land:destination:mss_objects_app:link_param:note_obj:delete',
       
        # Удельный показатель кадастровой стоимости
        'objects:land:destination:mss_objects_app:link_param:udelnij_pokazatel:delete',
        
        # Кадастровая стоимость
        'objects:land:destination:mss_objects_app:link_param:kadastr_price:delete',
        
        # Первоначальная стоимость
        'objects:land:destination:mss_objects_app:link_param:price_first:delete',
        
        # Оценочная стоимость
        'objects:land:destination:mss_objects_app:link_param:assessed_val:delete',
        
        # Процент износа
        'objects:land:destination:mss_objects_app:link_param:iznos:delete',
        
        # Состояние
        'objects:land:destination:mss_objects_app:link_param:state:delete',

        'objects:land:destination:mss_objects:delete',
        'objects:land:destination:mss_objects:drop___cad_quorter',
        'objects:land:destination:mss_objects:drop___kadastrno',
        'objects:land:destination:mss_objects:drop___oktmo',
        'objects:land:destination:mss_objects:drop___land_ownership',
        'objects:land:destination:mss_objects:drop___link_land_ownership',
        'objects:land:destination:mss_objects:drop___transition_rf_ms',
        'objects:land:destination:mss_objects:drop___link_transition_rf_ms',
        'objects:land:destination:mss_objects:drop___land_kateg',
        'objects:land:destination:mss_objects:drop___link_land_kateg',
        'objects:land:destination:mss_objects:drop___land_used',
        'objects:land:destination:mss_objects:drop___link_land_used',
        'objects:land:destination:mss_objects:drop___unmovable_used_new',
        'objects:land:destination:mss_objects:drop___link_unmovable_used_new',
        'objects:land:destination:mss_objects:drop___grounds_release_release_id',
        'objects:land:destination:mss_objects:drop___link_grounds_release_release_id',
        'objects:land:destination:mss_objects:drop___gr_rel_groups_gr_rel_group_id',
        'objects:land:destination:mss_objects:drop___link_gr_rel_groups_gr_rel_group_id',
        'objects:land:destination:mss_objects:drop___target_doc_target_doc_id',
        'objects:land:destination:mss_objects:drop___link_target_doc_target_doc_id',
        'objects:land:destination:mss_objects:drop___grounds_funk_using_grounds_funk_using_id',
        'objects:land:destination:mss_objects:drop___link_grounds_funk_using_grounds_funk_using_id',
        'objects:land:destination:mss_objects:drop___wow_obj',
        'objects:land:destination:mss_objects:drop___link_wow_obj',
        'objects:land:destination:mss_objects:drop___soc_zn_obj',
        'objects:land:destination:mss_objects:drop___link_soc_zn_obj',
        'objects:land:destination:mss_objects:drop___obj_zkx',
        'objects:land:destination:mss_objects:drop___link_obj_zkx',
        'objects:land:destination:mss_objects:drop___vid_obj_zkx',
        'objects:land:destination:mss_objects:drop___link_vid_obj_zkx',
        'objects:land:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:land:destination:mss_objects_adr:delete',
        'objects:land:source:___ids:drop___link_adr',
        'objects:land:source:___ids:drop___add_hist',
        'objects:land:source:___ids:drop___adr_str',
        'objects:land:destination:mss_adr:delete',
        'objects:land:source:states:drop___link_state',
      ]
    end
  end
end
