namespace :objects do
  namespace :land do
    namespace :import do

      task :tasks do
        Rake.invoke_task 'objects:land:source:___ids:insert', 'UNDELETABLE'
        Rake.invoke_task 'objects:land:destination:mss_objects:add___oktmo' 
        Rake.invoke_task 'objects:land:destination:mss_objects:add___kadastrno' 
        Rake.invoke_task 'objects:land:destination:mss_objects:add___land_ownership' 
        Rake.invoke_task 'objects:land:destination:mss_objects:add___transition_rf_ms' 
        Rake.invoke_task 'objects:land:destination:mss_objects:add___land_kateg' 
        Rake.invoke_task 'objects:land:destination:mss_objects:add___land_used' 
        Rake.invoke_task 'objects:land:destination:mss_objects:add___unmovable_used_new' 
        Rake.invoke_task 'objects:land:destination:mss_objects:add___grounds_release_release_id' 
        Rake.invoke_task 'objects:land:destination:mss_objects:add___gr_rel_groups_gr_rel_group_id' 
        Rake.invoke_task 'objects:land:destination:mss_objects:add___target_doc_target_doc_id' 
        Rake.invoke_task 'objects:land:destination:mss_objects:add___grounds_funk_using_grounds_funk_using_id' 
        Rake.invoke_task 'objects:land:destination:mss_objects:add___wow_obj' 
        Rake.invoke_task 'objects:land:destination:mss_objects:add___soc_zn_obj' 
        Rake.invoke_task 'objects:land:destination:mss_objects:add___obj_zkx' 
        Rake.invoke_task 'objects:land:destination:mss_objects:add___vid_obj_zkx' 
        Rake.invoke_task 'objects:land:source:___ids:add___link_adr'

        Rake.invoke_task 'objects:land:destination:mss_objects:insert' 
        Rake.invoke_task 'objects:land:source:___ids:update_link' 
        Rake.invoke_task 'objects:land:source:___ids:update___link_adr' 
        Rake.invoke_task 'objects:land:destination:mss_objects:update_link_oktmo'
        Rake.invoke_task 'objects:land:destination:mss_objects:update_inventar_num'
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___oktmo'
        Rake.invoke_task 'objects:land:destination:mss_objects:add___cad_quorter' 
        Rake.invoke_task 'objects:land:destination:mss_objects:update___cad_quorter'
        Rake.invoke_task 'objects:land:destination:mss_objects_dicts:object:dictionary_land_kvartals:insert'
        Rake.invoke_task 'objects:land:destination:mss_objects:update_link_cad_quorter'
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___cad_quorter'
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___kadastrno'
        Rake.invoke_task 'objects:land:destination:mss_objects_adr:insert'
        Rake.invoke_task 'objects:land:destination:mss_adr:update'
        Rake.invoke_task 'objects:land:source:___ids:drop___link_adr'

        # История адреса
        Rake.invoke_task 'objects:land:source:___ids:add___add_hist'
        Rake.invoke_task 'objects:land:source:___ids:update___add_hist'
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:add_hist:insert'
        Rake.invoke_task 'objects:land:source:___ids:drop___add_hist'
        
        # История наименования
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:obj_name_hist:insert'

        # Площадь
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:land_pl:insert'

        # Официальный адрес
        Rake.invoke_task 'objects:land:source:___ids:add___adr_str'
        Rake.invoke_task 'objects:land:source:___ids:update___adr_str'
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:adr_str:insert'
        Rake.invoke_task 'objects:land:source:___ids:drop___adr_str'

        # ID объекта из Сауми
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:id_obj:insert'

        # Условный номер
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:usl_n:insert'

        # Старый реестровый номер
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:rn_old:insert'

        # Собственность на землю
        Rake.invoke_task 'objects:land:destination:mss_objects:add___link_land_ownership' 
        Rake.invoke_task 'objects:land:destination:mss_objects:update___link_land_ownership' 
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:land_ownership:insert'
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___land_ownership' 
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___link_land_ownership' 
        
        # Переход из РФ в МС
        Rake.invoke_task 'objects:land:destination:mss_objects:add___link_transition_rf_ms' 
        Rake.invoke_task 'objects:land:destination:mss_objects:update___link_transition_rf_ms' 
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:transition_rf_ms:insert'
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___transition_rf_ms' 
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___link_transition_rf_ms' 
        
        # Категория земли
        Rake.invoke_task 'objects:land:destination:mss_objects:add___link_land_kateg' 
        Rake.invoke_task 'objects:land:destination:mss_objects:update___link_land_kateg' 
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:land_kateg:insert'
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___land_kateg' 
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___link_land_kateg' 
       
        # Вид разрешенного использования
        Rake.invoke_task 'objects:land:destination:mss_objects:add___link_land_used' 
        Rake.invoke_task 'objects:land:destination:mss_objects:update___link_land_used' 
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:land_used:insert'
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___land_used' 
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___link_land_used' 
       
        # Целевое назначение 
        Rake.invoke_task 'objects:land:destination:mss_objects:add___link_unmovable_used_new' 
        Rake.invoke_task 'objects:land:destination:mss_objects:update___link_unmovable_used_new' 
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:unmovable_used_new:insert'
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___unmovable_used_new' 
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___link_unmovable_used_new' 
        
        # разрешенное использование Сауми
        Rake.invoke_task 'objects:land:destination:mss_objects:add___link_grounds_release_release_id' 
        Rake.invoke_task 'objects:land:destination:mss_objects:update___link_grounds_release_release_id' 
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:grounds_release_release_id:insert'
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___grounds_release_release_id' 
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___link_grounds_release_release_id' 
        
        # Вид разрешенного использования Сауми
        Rake.invoke_task 'objects:land:destination:mss_objects:add___link_gr_rel_groups_gr_rel_group_id' 
        Rake.invoke_task 'objects:land:destination:mss_objects:update___link_gr_rel_groups_gr_rel_group_id' 
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:gr_rel_groups_gr_rel_group_id:insert'
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___gr_rel_groups_gr_rel_group_id' 
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___link_gr_rel_groups_gr_rel_group_id' 
        
        # разрешенное использования по градостроительным нормам Сауми
        Rake.invoke_task 'objects:land:destination:mss_objects:add___link_target_doc_target_doc_id' 
        Rake.invoke_task 'objects:land:destination:mss_objects:update___link_target_doc_target_doc_id' 
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:target_doc_target_doc_id:insert'
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___target_doc_target_doc_id' 
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___link_target_doc_target_doc_id' 
        
        # вид целевого использования Сауми
        Rake.invoke_task 'objects:land:destination:mss_objects:add___link_grounds_funk_using_grounds_funk_using_id' 
        Rake.invoke_task 'objects:land:destination:mss_objects:update___link_grounds_funk_using_grounds_funk_using_id' 
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:grounds_funk_using_grounds_funk_using_id:insert'
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___grounds_funk_using_grounds_funk_using_id' 
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___link_grounds_funk_using_grounds_funk_using_id' 
        
        # знаковый объект
        Rake.invoke_task 'objects:land:destination:mss_objects:add___link_wow_obj' 
        Rake.invoke_task 'objects:land:destination:mss_objects:update___link_wow_obj' 
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:wow_obj:insert'
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___wow_obj' 
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___link_wow_obj' 
        
        # социально-значимый объект
        Rake.invoke_task 'objects:land:destination:mss_objects:add___link_soc_zn_obj' 
        Rake.invoke_task 'objects:land:destination:mss_objects:update___link_soc_zn_obj' 
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:soc_zn_obj:insert'
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___soc_zn_obj' 
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___link_soc_zn_obj' 
        
        # объект жкх 
        Rake.invoke_task 'objects:land:destination:mss_objects:add___link_obj_zkx' 
        Rake.invoke_task 'objects:land:destination:mss_objects:update___link_obj_zkx' 
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:obj_zkx:insert'
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___obj_zkx' 
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___link_obj_zkx' 
       
        # вид объекта жкх
        Rake.invoke_task 'objects:land:destination:mss_objects:add___link_vid_obj_zkx' 
        Rake.invoke_task 'objects:land:destination:mss_objects:update___link_vid_obj_zkx' 
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:vid_obj_zkx:insert'
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___vid_obj_zkx' 
        Rake.invoke_task 'objects:land:destination:mss_objects:drop___link_vid_obj_zkx' 

        # примечание
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:note_obj:insert'
        
        # Удельный показатель кадастровой стоимости
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:udelnij_pokazatel:insert'
        
        # Кадастровая стоимость
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:kadastr_price:insert'
        
        # Первоначальная стоимость
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:price_first:insert'
        
        # Оценочная стоимость
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:assessed_val:insert'
        
        # Процент износа 
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:iznos:insert'
        
        # Состояние
        Rake.invoke_task 'objects:land:source:states:add___link_state' 
        Rake.invoke_task 'objects:land:source:states:update___link_state' 
        Rake.invoke_task 'objects:land:destination:mss_objects_app:link_param:state:insert'
        Rake.invoke_task 'objects:land:source:states:drop___link_state' 
        
        # Привязка документов
        Rake.invoke_task 'objects:land:source:___ids:add___link_list'
        Rake.invoke_task 'objects:land:source:___ids:update___link_list'
        Rake.invoke_task 'objects:land:destination:mss_detail_list:insert'
        Rake.invoke_task 'objects:land:source:___ids:drop___link_list'
      end 

    end
  end
end
