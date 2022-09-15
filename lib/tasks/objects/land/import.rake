Dir[File.expand_path('../**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :land do
    namespace :import do
      task :tasks => [
        'objects:land:source:ids:insert',
        'objects:land:destination:mss_objects:add___oktmo', 
        'objects:land:destination:mss_objects:add___kadastrno', 
        'objects:land:destination:mss_objects:add___land_ownership', 
        'objects:land:destination:mss_objects:add___transition_rf_ms', 
        'objects:land:destination:mss_objects:add___land_kateg', 
        'objects:land:destination:mss_objects:add___land_used', 
        'objects:land:destination:mss_objects:add___unmovable_used_new', 
        'objects:land:destination:mss_objects:add___grounds_release_release_id', 
        'objects:land:destination:mss_objects:add___gr_rel_groups_gr_rel_group_id', 
        'objects:land:destination:mss_objects:add___target_doc_target_doc_id', 
        'objects:land:destination:mss_objects:add___grounds_funk_using_grounds_funk_using_id', 
        'objects:land:destination:mss_objects:add___wow_obj', 
        'objects:land:destination:mss_objects:add___soc_zn_obj', 
        'objects:land:destination:mss_objects:add___obj_zkx', 
        'objects:land:destination:mss_objects:add___vid_obj_zkx', 
        
        'objects:land:source:ids:add___link_adr',
        'objects:land:destination:mss_objects:insert', 
        'objects:land:source:ids:update_link', 
        'objects:land:source:ids:update___link_adr', 
        'objects:land:destination:mss_objects:update_link_oktmo',
        'objects:land:destination:mss_objects:update_inventar_num',
        'objects:land:destination:mss_objects:drop___oktmo',
        'objects:land:destination:mss_objects:add___cad_quorter', 
        'objects:land:destination:mss_objects:update___cad_quorter',
        'objects:land:destination:mss_objects_dicts:object:dictionary_land_kvartals:insert',
        'objects:land:destination:mss_objects:update_link_cad_quorter',
        'objects:land:destination:mss_objects:drop___cad_quorter',
        'objects:land:destination:mss_objects:drop___kadastrno',
        'objects:land:destination:mss_objects_adr:insert',
        'objects:land:destination:mss_adr:update',
        'objects:land:source:ids:drop___link_adr',
        'objects:land:source:ids:add___add_hist',
        'objects:land:source:ids:update___add_hist',
        'objects:land:destination:mss_objects_app:add_hist:insert',
        'objects:land:source:ids:drop___add_hist',
        'objects:land:destination:mss_objects_app:obj_name_hist:insert',
        'objects:land:destination:mss_objects_app:land_pl:insert',
        'objects:land:source:ids:add___adr_str',
        'objects:land:source:ids:update___adr_str',
        'objects:land:destination:mss_objects_app:adr_str:insert',
        'objects:land:source:ids:drop___adr_str',
        'objects:land:destination:mss_objects_app:id_obj:insert',
        'objects:land:destination:mss_objects_app:usl_n:insert',
        'objects:land:destination:mss_objects_app:rn_old:insert',

        'objects:land:destination:mss_objects:add___link_land_ownership', 
        'objects:land:destination:mss_objects:update___link_land_ownership', 
        'objects:land:destination:mss_objects_app:land_ownership:insert',
        'objects:land:destination:mss_objects:drop___land_ownership', 
        'objects:land:destination:mss_objects:drop___link_land_ownership', 
        
        'objects:land:destination:mss_objects:add___link_transition_rf_ms', 
        'objects:land:destination:mss_objects:update___link_transition_rf_ms', 
        'objects:land:destination:mss_objects_app:transition_rf_ms:insert',
        'objects:land:destination:mss_objects:drop___transition_rf_ms', 
        'objects:land:destination:mss_objects:drop___link_transition_rf_ms', 
        
        # Категория земли
        'objects:land:destination:mss_objects:add___link_land_kateg', 
        'objects:land:destination:mss_objects:update___link_land_kateg', 
        'objects:land:destination:mss_objects_app:land_kateg:insert',
        'objects:land:destination:mss_objects:drop___land_kateg', 
        'objects:land:destination:mss_objects:drop___link_land_kateg', 
        
        'objects:land:destination:mss_objects:add___link_land_used', 
        'objects:land:destination:mss_objects:update___link_land_used', 
        'objects:land:destination:mss_objects_app:land_used:insert',
        'objects:land:destination:mss_objects:drop___land_used', 
        'objects:land:destination:mss_objects:drop___link_land_used', 
       
        'objects:land:destination:mss_objects:add___link_unmovable_used_new', 
        'objects:land:destination:mss_objects:update___link_unmovable_used_new', 
        'objects:land:destination:mss_objects_app:unmovable_used_new:insert',
        'objects:land:destination:mss_objects:drop___unmovable_used_new', 
        'objects:land:destination:mss_objects:drop___link_unmovable_used_new', 
        
        # разрешенное использование Сауми
        'objects:land:destination:mss_objects:add___link_grounds_release_release_id', 
        'objects:land:destination:mss_objects:update___link_grounds_release_release_id', 
        'objects:land:destination:mss_objects_app:grounds_release_release_id:insert',
        'objects:land:destination:mss_objects:drop___grounds_release_release_id', 
        'objects:land:destination:mss_objects:drop___link_grounds_release_release_id', 
        
        # Вид разрешенного использования Сауми
        'objects:land:destination:mss_objects:add___link_gr_rel_groups_gr_rel_group_id', 
        'objects:land:destination:mss_objects:update___link_gr_rel_groups_gr_rel_group_id', 
        'objects:land:destination:mss_objects_app:gr_rel_groups_gr_rel_group_id:insert',
        'objects:land:destination:mss_objects:drop___gr_rel_groups_gr_rel_group_id', 
        'objects:land:destination:mss_objects:drop___link_gr_rel_groups_gr_rel_group_id', 
        
        # разрешенное использования по градостроительным нормам Сауми
        'objects:land:destination:mss_objects:add___link_target_doc_target_doc_id', 
        'objects:land:destination:mss_objects:update___link_target_doc_target_doc_id', 
        'objects:land:destination:mss_objects_app:target_doc_target_doc_id:insert',
        'objects:land:destination:mss_objects:drop___target_doc_target_doc_id', 
        'objects:land:destination:mss_objects:drop___link_target_doc_target_doc_id', 
        
        # вид целевого использования Сауми
        'objects:land:destination:mss_objects:add___link_grounds_funk_using_grounds_funk_using_id', 
        'objects:land:destination:mss_objects:update___link_grounds_funk_using_grounds_funk_using_id', 
        'objects:land:destination:mss_objects_app:grounds_funk_using_grounds_funk_using_id:insert',
        'objects:land:destination:mss_objects:drop___grounds_funk_using_grounds_funk_using_id', 
        'objects:land:destination:mss_objects:drop___link_grounds_funk_using_grounds_funk_using_id', 
        
        # знаковый объект
        'objects:land:destination:mss_objects:add___link_wow_obj', 
        'objects:land:destination:mss_objects:update___link_wow_obj', 
        'objects:land:destination:mss_objects_app:wow_obj:insert',
        'objects:land:destination:mss_objects:drop___wow_obj', 
        'objects:land:destination:mss_objects:drop___link_wow_obj', 
        
        # социально-значимый объект
        'objects:land:destination:mss_objects:add___link_soc_zn_obj', 
        'objects:land:destination:mss_objects:update___link_soc_zn_obj', 
        'objects:land:destination:mss_objects_app:soc_zn_obj:insert',
        'objects:land:destination:mss_objects:drop___soc_zn_obj', 
        'objects:land:destination:mss_objects:drop___link_soc_zn_obj', 
        
        # объект жкх 
        'objects:land:destination:mss_objects:add___link_obj_zkx', 
        'objects:land:destination:mss_objects:update___link_obj_zkx', 
        'objects:land:destination:mss_objects_app:obj_zkx:insert',
        'objects:land:destination:mss_objects:drop___obj_zkx', 
        'objects:land:destination:mss_objects:drop___link_obj_zkx', 
       
        # вид объекта жкх
        'objects:land:destination:mss_objects:add___link_vid_obj_zkx', 
        'objects:land:destination:mss_objects:update___link_vid_obj_zkx', 
        'objects:land:destination:mss_objects_app:vid_obj_zkx:insert',
        'objects:land:destination:mss_objects:drop___vid_obj_zkx', 
        'objects:land:destination:mss_objects:drop___link_vid_obj_zkx', 

        # примечание
        'objects:land:destination:mss_objects_app:note_obj:insert',

      ]
    end
  end
end
