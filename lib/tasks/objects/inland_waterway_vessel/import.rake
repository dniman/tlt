namespace :objects do
  namespace :inland_waterway_vessel do
    namespace :import do

      task :tasks do 
        Rake.invoke_task 'objects:inland_waterway_vessel:source:ids:insert'
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:add___type_transport' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:add___automaker' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:add___engine_type' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:add___auto_country' 

        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:insert'
        Rake.invoke_task 'objects:inland_waterway_vessel:source:ids:update_link'

        # История наименования
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:obj_name_hist:insert'
        
        # История инвентарного номера
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:obj_invnum_hist:insert'
        
        # ID объекта из Сауми
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:id_obj:insert'
        
        # Код ОКОФ
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:okof:insert'
        
        # Старый реестровый номер
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:rn_old:insert'
        
        # Примечание 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:note_obj:insert'
        
        # Модель транспортного средства
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:movable_model:insert'
        
        # Год выпуска
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:movable_year:insert'
        
        # Государственный регистрационный номер
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:vessel_reg_num:insert'
        
        # Номер двигателя
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:dvigat_num:insert'
        
        # Номер кузова
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:kuzov_num:insert'
        
        # Тип транспорта
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:add___link_type_transport' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:update___link_type_transport' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:type_transport:insert'
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:drop___type_transport' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:drop___link_type_transport' 
        
        # Марка транспортного средства
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:add___link_automaker' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:update___link_automaker' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:automaker:insert'
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:drop___automaker' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:drop___link_automaker' 
        
        # Мощность двигателя
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:power_dvig:insert'
        
        # Объем двигателя
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:v_dvigatel:insert'
        
        # Тип двигателя
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:add___link_engine_type' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:update___link_engine_type' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:engine_type:insert'
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:drop___engine_type' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:drop___link_engine_type' 
        
        # Разрешенная максимальная масса
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:razresh_max_mas:insert'
        
        # Масса без нагрузки
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:mass_without_load:insert'
        
        # Изготовитель(страна)
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:add___link_auto_country' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:update___link_auto_country' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:auto_country:insert'
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:drop___auto_country' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:drop___link_auto_country' 
      end 

    end
  end
end
