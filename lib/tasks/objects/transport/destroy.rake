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
        
        # Разделы
        #'objects:transport:destination:mss_objects_app:section:delete',

        # Удаление основного объекта
        'objects:transport:destination:mss_objects:delete',

         # Удаление дополнительных колонок
        'objects:transport:destination:mss_objects:drop___type_transport',
        'objects:transport:destination:mss_objects:drop___link_type_transport',
        'objects:transport:destination:mss_objects:drop___automaker',
        'objects:transport:destination:mss_objects:drop___link_automaker',
        #'objects:transport:destination:mss_objects:drop___section',
        #'objects:transport:destination:mss_objects:drop___link_section',
      ]
    end
  end
end
