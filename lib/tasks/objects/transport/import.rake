namespace :objects do
  namespace :transport do
    namespace :import do

      task :tasks do 
        Rake.invoke_task 'objects:transport:source:ids:insert'
        Rake.invoke_task 'objects:transport:destination:mss_objects:add___type_transport' 
        Rake.invoke_task 'objects:transport:destination:mss_objects:add___automaker' 
        Rake.invoke_task 'objects:transport:destination:mss_objects:add___color_kuzov' 
        Rake.invoke_task 'objects:transport:destination:mss_objects:add___engine_type' 

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
        
        # Тип транспорта
        Rake.invoke_task 'objects:transport:destination:mss_objects:add___link_type_transport' 
        Rake.invoke_task 'objects:transport:destination:mss_objects:update___link_type_transport' 
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:type_transport:insert'
        Rake.invoke_task 'objects:transport:destination:mss_objects:drop___type_transport' 
        Rake.invoke_task 'objects:transport:destination:mss_objects:drop___link_type_transport' 
        
        # Марка транспортного средства
        Rake.invoke_task 'objects:transport:destination:mss_objects:add___link_automaker' 
        Rake.invoke_task 'objects:transport:destination:mss_objects:update___link_automaker' 
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:automaker:insert'
        Rake.invoke_task 'objects:transport:destination:mss_objects:drop___automaker' 
        Rake.invoke_task 'objects:transport:destination:mss_objects:drop___link_automaker' 
        
        # Идентификационный номер(VIN)
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:vin_num:insert'
        
        # Цвет кузова
        Rake.invoke_task 'objects:transport:destination:mss_objects:add___link_color_kuzov' 
        Rake.invoke_task 'objects:transport:destination:mss_objects:update___link_color_kuzov' 
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:color_kuzov:insert'
        Rake.invoke_task 'objects:transport:destination:mss_objects:drop___color_kuzov' 
        Rake.invoke_task 'objects:transport:destination:mss_objects:drop___link_color_kuzov' 
        
        # Мощность двигателя
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:power_dvig:insert'
        
        # Объем двигателя
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:v_dvigatel:insert'
        
        # Тип двигателя
        Rake.invoke_task 'objects:transport:destination:mss_objects:add___link_engine_type' 
        Rake.invoke_task 'objects:transport:destination:mss_objects:update___link_engine_type' 
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:engine_type:insert'
        Rake.invoke_task 'objects:transport:destination:mss_objects:drop___engine_type' 
        Rake.invoke_task 'objects:transport:destination:mss_objects:drop___link_engine_type' 
        
        # Разрешенная максимальная масса
        Rake.invoke_task 'objects:transport:destination:mss_objects_app:razresh_max_mas:insert'
      end 

    end
  end
end
