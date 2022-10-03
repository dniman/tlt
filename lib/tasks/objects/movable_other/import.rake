namespace :objects do
  namespace :movable_other do
    namespace :import do

      task :tasks do 
        Rake.invoke_task 'objects:movable_other:source:ids:insert'
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:add___dict_name' 

        Rake.invoke_task 'objects:movable_other:destination:mss_objects:insert'
        Rake.invoke_task 'objects:movable_other:source:ids:update_link'

        # Адрес последнего местоположения
        Rake.invoke_task 'objects:movable_other:source:ids:add___last_loc_addr'
        Rake.invoke_task 'objects:movable_other:source:ids:update___last_loc_addr'
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:last_loc_addr:insert'
        Rake.invoke_task 'objects:movable_other:source:ids:drop___last_loc_addr'
        
        # История наименования
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:obj_name_hist:insert'
        
        # ID объекта из Сауми
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:id_obj:insert'
        
        # Старый реестровый номер
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:rn_old:insert'
        
        # Примечание 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:note_obj:insert'
        
        # Значение из справочника наименований
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:add___link_dict_name' 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:update___link_dict_name' 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:dict_name:insert'
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:drop___dict_name' 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:drop___link_dict_name' 
      end 

    end
  end
end
