namespace :objects do
  namespace :partnership do
    namespace :import do

      task :tasks do 
        Rake.invoke_task 'objects:partnership:source:ids:insert'
        #Rake.invoke_task 'objects:partnership:destination:mss_objects:add___dict_name' 
        #Rake.invoke_task 'objects:partnership:destination:mss_objects:add___group' 
        #Rake.invoke_task 'objects:partnership:destination:mss_objects:add___section' 

        Rake.invoke_task 'objects:partnership:destination:mss_objects:insert'
        Rake.invoke_task 'objects:partnership:source:ids:update_link'

        # История наименования
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:obj_name_hist:insert'
        
        # ID объекта из Сауми
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:id_obj:insert'
        
        # Старый реестровый номер
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:rn_old:insert'
        
        # Примечание 
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:note_obj:insert'
        
        # Значение из справочника наименований
        #Rake.invoke_task 'objects:partnership:destination:mss_objects:add___link_dict_name' 
        #Rake.invoke_task 'objects:partnership:destination:mss_objects:update___link_dict_name' 
        #Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:dict_name:insert'
        #Rake.invoke_task 'objects:partnership:destination:mss_objects:drop___dict_name' 
        #Rake.invoke_task 'objects:partnership:destination:mss_objects:drop___link_dict_name' 
        
        # Группы
        #Rake.invoke_task 'objects:partnership:destination:mss_objects:add___link_group' 
        #Rake.invoke_task 'objects:partnership:destination:mss_objects:update___link_group' 
        #Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:group:insert'
        #Rake.invoke_task 'objects:partnership:destination:mss_objects:drop___group' 
        #Rake.invoke_task 'objects:partnership:destination:mss_objects:drop___link_group' 
        
        # Разделы
        #Rake.invoke_task 'objects:partnership:destination:mss_objects:add___link_section' 
        #Rake.invoke_task 'objects:partnership:destination:mss_objects:update___link_section' 
        #Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:section:insert'
        #Rake.invoke_task 'objects:partnership:destination:mss_objects:drop___section' 
        #Rake.invoke_task 'objects:partnership:destination:mss_objects:drop___link_section' 
      end 

    end
  end
end
