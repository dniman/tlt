namespace :objects do
  namespace :transport do
    namespace :destroy do
      task :tasks => [
        # История наименования
        'objects:transport:destination:mss_objects_app:obj_name_hist:delete',

        # ID объекта из Сауми
        'objects:transport:destination:mss_objects_app:id_obj:delete',
        
        # Старый реестровый номер
        'objects:transport:destination:mss_objects_app:rn_old:delete',
        
        # Примечание 
        'objects:transport:destination:mss_objects_app:note_obj:delete',
        
        # Модель транспортного средства
        'objects:transport:destination:mss_objects_app:movable_model:delete',
        
        # Год выпуска
        'objects:transport:destination:mss_objects_app:movable_year:delete',
        
        # Государственный регистрационный номер
        'objects:transport:destination:mss_objects_app:transport_reg_n:delete',
        
        # Номер двигателя
        'objects:transport:destination:mss_objects_app:dvigat_num:delete',
        
        # Номер шасси(рамы) 
        'objects:transport:destination:mss_objects_app:shassi_num:delete',

        # Номер кузова
        'objects:transport:destination:mss_objects_app:kuzov_num:delete',

        # Тип транспорта
        'objects:transport:destination:mss_objects_app:type_transport:delete',
        
        # Марка транспортного средства
        'objects:transport:destination:mss_objects_app:automaker:delete',
        
        # Идентификационный номер(VIN)
        'objects:transport:destination:mss_objects_app:vin_num:delete',
        
        # Цвет кузова
        'objects:transport:destination:mss_objects_app:color_kuzov:delete',
        
        # Мощность двигателя
        'objects:transport:destination:mss_objects_app:power_dvig:delete',
        
        # Объем двигателя
        'objects:transport:destination:mss_objects_app:v_dvigatel:delete',
        
        # Тип двигателя
        'objects:transport:destination:mss_objects_app:engine_type:delete',
        
        # Разрешенная максимальная масса
        'objects:transport:destination:mss_objects_app:razresh_max_mas:delete',

        ###
        # Удаление основного объекта
        'objects:transport:destination:mss_objects:delete',

         # Удаление дополнительных колонок
        'objects:transport:destination:mss_objects:drop___type_transport',
        'objects:transport:destination:mss_objects:drop___link_type_transport',
        'objects:transport:destination:mss_objects:drop___automaker',
        'objects:transport:destination:mss_objects:drop___link_automaker',
        'objects:transport:destination:mss_objects:drop___color_kuzov',
        'objects:transport:destination:mss_objects:drop___link_color_kuzov',
        'objects:transport:destination:mss_objects:drop___engine_type',
        'objects:transport:destination:mss_objects:drop___link_engine_type',
      ]
    end
  end
end
