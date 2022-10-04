namespace :objects do
  namespace :transport do
    namespace :import do

      task :tasks do 
        Rake.invoke_task 'objects:transport:source:ids:insert'
        #Rake.invoke_task 'objects:transport:destination:mss_objects:add___dict_name' 
        #Rake.invoke_task 'objects:transport:destination:mss_objects:add___group' 
        #Rake.invoke_task 'objects:transport:destination:mss_objects:add___section' 

        Rake.invoke_task 'objects:transport:destination:mss_objects:insert'
        Rake.invoke_task 'objects:transport:source:ids:update_link'

        # История наименования
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:obj_name_hist:insert'
        
        # ID объекта из Сауми
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:id_obj:insert'
        
        # Старый реестровый номер
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:rn_old:insert'
        
        # Примечание 
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:note_obj:insert'
        
        # Модель транспортного средства
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:movable_model:insert'
        
        # Год выпуска
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:movable_year:insert'
        
        # Государственный регистрационный номер
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:transport_reg_n:insert'
        
        # Номер двигателя
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:dvigat_num:insert'
        
        # Номер шасси(рамы) 
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:shassi_num:insert'
        
        # Номер кузова
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:kuzov_num:insert'
        
        # Значение из справочника наименований
        #Rake.invoke_task 'objects:transport:destination:mss_objects:add___link_dict_name' 
        #Rake.invoke_task 'objects:transport:destination:mss_objects:update___link_dict_name' 
        #Rake.invoke_task 'objects:transport:destination:mss_objects_app:dict_name:insert'
        #Rake.invoke_task 'objects:transport:destination:mss_objects:drop___dict_name' 
        #Rake.invoke_task 'objects:transport:destination:mss_objects:drop___link_dict_name' 
        
        # Группы
        #Rake.invoke_task 'objects:transport:destination:mss_objects:add___link_group' 
        #Rake.invoke_task 'objects:transport:destination:mss_objects:update___link_group' 
        #Rake.invoke_task 'objects:transport:destination:mss_objects_app:group:insert'
        #Rake.invoke_task 'objects:transport:destination:mss_objects:drop___group' 
        #Rake.invoke_task 'objects:transport:destination:mss_objects:drop___link_group' 
        
        # Разделы
        #Rake.invoke_task 'objects:transport:destination:mss_objects:add___link_section' 
        #Rake.invoke_task 'objects:transport:destination:mss_objects:update___link_section' 
        #Rake.invoke_task 'objects:transport:destination:mss_objects_app:section:insert'
        #Rake.invoke_task 'objects:transport:destination:mss_objects:drop___section' 
        #Rake.invoke_task 'objects:transport:destination:mss_objects:drop___link_section' 
      end 

    end
  end
end
