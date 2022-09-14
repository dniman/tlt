Dir[File.expand_path('../land/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :land do
    task :tasks => [
      'import:land:source:ids:insert',
      'import:land:destination:mss_objects:add___oktmo', 
      'import:land:destination:mss_objects:add___kadastrno', 
      'import:land:destination:mss_objects:add___land_ownership', 
      'import:land:destination:mss_objects:add___transition_rf_ms', 
      'import:land:destination:mss_objects:add___land_kateg', 
      'import:land:destination:mss_objects:add___land_used', 
      'import:land:destination:mss_objects:add___unmovable_used_new', 
      'import:land:destination:mss_objects:add___grounds_release_release_id', 
      'import:land:destination:mss_objects:add___gr_rel_groups_gr_rel_group_id', 
      'import:land:destination:mss_objects:add___target_doc_target_doc_id', 
      'import:land:destination:mss_objects:add___grounds_funk_using_grounds_funk_using_id', 
      'import:land:destination:mss_objects:add___wow_obj', 
      'import:land:destination:mss_objects:add___soc_zn_obj', 
      'import:land:destination:mss_objects:add___obj_zkx', 
      'import:land:destination:mss_objects:add___vid_obj_zkx', 
      
      'import:land:source:ids:add___link_adr',
      'import:land:destination:mss_objects:insert', 
      'import:land:source:ids:update_link', 
      'import:land:source:ids:update___link_adr', 
      'import:land:destination:mss_objects:update_link_oktmo',
      'import:land:destination:mss_objects:update_inventar_num',
      'import:land:destination:mss_objects:drop___oktmo',
      'import:land:destination:mss_objects:add___cad_quorter', 
      'import:land:destination:mss_objects:update___cad_quorter',
      'import:land:destination:mss_objects_dicts:object:dictionary_land_kvartals:insert',
      'import:land:destination:mss_objects:update_link_cad_quorter',
      'import:land:destination:mss_objects:drop___cad_quorter',
      'import:land:destination:mss_objects:drop___kadastrno',
      'import:land:destination:mss_objects_adr:insert',
      'import:land:destination:mss_adr:update',
      'import:land:source:ids:drop___link_adr',
      'import:land:source:ids:add___add_hist',
      'import:land:source:ids:update___add_hist',
      'import:land:destination:mss_objects_app:add_hist:insert',
      'import:land:source:ids:drop___add_hist',
      'import:land:destination:mss_objects_app:obj_name_hist:insert',
      'import:land:destination:mss_objects_app:land_pl:insert',
      'import:land:source:ids:add___adr_str',
      'import:land:source:ids:update___adr_str',
      'import:land:destination:mss_objects_app:adr_str:insert',
      'import:land:source:ids:drop___adr_str',
      'import:land:destination:mss_objects_app:id_obj:insert',
      'import:land:destination:mss_objects_app:usl_n:insert',
      'import:land:destination:mss_objects_app:rn_old:insert',

      'import:land:destination:mss_objects:add___link_land_ownership', 
      'import:land:destination:mss_objects:update___link_land_ownership', 
      'import:land:destination:mss_objects_app:land_ownership:insert',
      'import:land:destination:mss_objects:drop___land_ownership', 
      'import:land:destination:mss_objects:drop___link_land_ownership', 
      
      'import:land:destination:mss_objects:add___link_transition_rf_ms', 
      'import:land:destination:mss_objects:update___link_transition_rf_ms', 
      'import:land:destination:mss_objects_app:transition_rf_ms:insert',
      'import:land:destination:mss_objects:drop___transition_rf_ms', 
      'import:land:destination:mss_objects:drop___link_transition_rf_ms', 
      
      # Категория земли
      'import:land:destination:mss_objects:add___link_land_kateg', 
      'import:land:destination:mss_objects:update___link_land_kateg', 
      'import:land:destination:mss_objects_app:land_kateg:insert',
      'import:land:destination:mss_objects:drop___land_kateg', 
      'import:land:destination:mss_objects:drop___link_land_kateg', 
      
      'import:land:destination:mss_objects:add___link_land_used', 
      'import:land:destination:mss_objects:update___link_land_used', 
      'import:land:destination:mss_objects_app:land_used:insert',
      'import:land:destination:mss_objects:drop___land_used', 
      'import:land:destination:mss_objects:drop___link_land_used', 
     
      'import:land:destination:mss_objects:add___link_unmovable_used_new', 
      'import:land:destination:mss_objects:update___link_unmovable_used_new', 
      'import:land:destination:mss_objects_app:unmovable_used_new:insert',
      'import:land:destination:mss_objects:drop___unmovable_used_new', 
      'import:land:destination:mss_objects:drop___link_unmovable_used_new', 
      
      # разрешенное использование Сауми
      'import:land:destination:mss_objects:add___link_grounds_release_release_id', 
      'import:land:destination:mss_objects:update___link_grounds_release_release_id', 
      'import:land:destination:mss_objects_app:grounds_release_release_id:insert',
      'import:land:destination:mss_objects:drop___grounds_release_release_id', 
      'import:land:destination:mss_objects:drop___link_grounds_release_release_id', 
      
      # Вид разрешенного использования Сауми
      'import:land:destination:mss_objects:add___link_gr_rel_groups_gr_rel_group_id', 
      'import:land:destination:mss_objects:update___link_gr_rel_groups_gr_rel_group_id', 
      'import:land:destination:mss_objects_app:gr_rel_groups_gr_rel_group_id:insert',
      'import:land:destination:mss_objects:drop___gr_rel_groups_gr_rel_group_id', 
      'import:land:destination:mss_objects:drop___link_gr_rel_groups_gr_rel_group_id', 
      
      # разрешенное использования по градостроительным нормам Сауми
      'import:land:destination:mss_objects:add___link_target_doc_target_doc_id', 
      'import:land:destination:mss_objects:update___link_target_doc_target_doc_id', 
      'import:land:destination:mss_objects_app:target_doc_target_doc_id:insert',
      'import:land:destination:mss_objects:drop___target_doc_target_doc_id', 
      'import:land:destination:mss_objects:drop___link_target_doc_target_doc_id', 
      
      # вид целевого использования Сауми
      'import:land:destination:mss_objects:add___link_grounds_funk_using_grounds_funk_using_id', 
      'import:land:destination:mss_objects:update___link_grounds_funk_using_grounds_funk_using_id', 
      'import:land:destination:mss_objects_app:grounds_funk_using_grounds_funk_using_id:insert',
      'import:land:destination:mss_objects:drop___grounds_funk_using_grounds_funk_using_id', 
      'import:land:destination:mss_objects:drop___link_grounds_funk_using_grounds_funk_using_id', 
      
      # знаковый объект
      'import:land:destination:mss_objects:add___link_wow_obj', 
      'import:land:destination:mss_objects:update___link_wow_obj', 
      'import:land:destination:mss_objects_app:wow_obj:insert',
      'import:land:destination:mss_objects:drop___wow_obj', 
      'import:land:destination:mss_objects:drop___link_wow_obj', 
      
      # социально-значимый объект
      'import:land:destination:mss_objects:add___link_soc_zn_obj', 
      'import:land:destination:mss_objects:update___link_soc_zn_obj', 
      'import:land:destination:mss_objects_app:soc_zn_obj:insert',
      'import:land:destination:mss_objects:drop___soc_zn_obj', 
      'import:land:destination:mss_objects:drop___link_soc_zn_obj', 
      
      # объект жкх 
      'import:land:destination:mss_objects:add___link_obj_zkx', 
      'import:land:destination:mss_objects:update___link_obj_zkx', 
      'import:land:destination:mss_objects_app:obj_zkx:insert',
      'import:land:destination:mss_objects:drop___obj_zkx', 
      'import:land:destination:mss_objects:drop___link_obj_zkx', 
     
      # вид объекта жкх
      'import:land:destination:mss_objects:add___link_vid_obj_zkx', 
      'import:land:destination:mss_objects:update___link_vid_obj_zkx', 
      'import:land:destination:mss_objects_app:vid_obj_zkx:insert',
      'import:land:destination:mss_objects:drop___vid_obj_zkx', 
      'import:land:destination:mss_objects:drop___link_vid_obj_zkx', 
    ]
  end
end
