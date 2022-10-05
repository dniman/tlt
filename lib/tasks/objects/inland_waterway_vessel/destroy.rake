namespace :objects do
  namespace :inland_waterway_vessel do
    namespace :destroy do
      task :tasks => [
        # История наименования
        'objects:inland_waterway_vessel:destination:mss_objects_app:obj_name_hist:delete',

        # ID объекта из Сауми
        'objects:inland_waterway_vessel:destination:mss_objects_app:id_obj:delete',
        
        # Старый реестровый номер
        'objects:inland_waterway_vessel:destination:mss_objects_app:rn_old:delete',
        
        # Примечание 
        'objects:inland_waterway_vessel:destination:mss_objects_app:note_obj:delete',
        
        # Модель транспортного средства
        'objects:inland_waterway_vessel:destination:mss_objects_app:movable_model:delete',
        
        # Год выпуска
        'objects:inland_waterway_vessel:destination:mss_objects_app:movable_year:delete',
        
        # Государственный регистрационный номер
        'objects:inland_waterway_vessel:destination:mss_objects_app:inland_waterway_vessel_reg_n:delete',
        
        # Номер двигателя
        'objects:inland_waterway_vessel:destination:mss_objects_app:dvigat_num:delete',
        
        # Номер шасси(рамы) 
        'objects:inland_waterway_vessel:destination:mss_objects_app:shassi_num:delete',

        # Номер кузова
        'objects:inland_waterway_vessel:destination:mss_objects_app:kuzov_num:delete',

        # Тип транспорта
        'objects:inland_waterway_vessel:destination:mss_objects_app:type_transport:delete',
        
        # Марка транспортного средства
        'objects:inland_waterway_vessel:destination:mss_objects_app:automaker:delete',
        
        # Идентификационный номер(VIN)
        'objects:inland_waterway_vessel:destination:mss_objects_app:vin_num:delete',
        
        # Цвет кузова
        'objects:inland_waterway_vessel:destination:mss_objects_app:color_kuzov:delete',
        
        # Мощность двигателя
        'objects:inland_waterway_vessel:destination:mss_objects_app:power_dvig:delete',
        
        # Объем двигателя
        'objects:inland_waterway_vessel:destination:mss_objects_app:v_dvigatel:delete',
        
        # Тип двигателя
        'objects:inland_waterway_vessel:destination:mss_objects_app:engine_type:delete',
        
        # Разрешенная максимальная масса
        'objects:inland_waterway_vessel:destination:mss_objects_app:razresh_max_mas:delete',
        
        # Масса без нагрузки
        'objects:inland_waterway_vessel:destination:mss_objects_app:mass_without_load:delete',
        
        # Изготовитель(страна)
        'objects:inland_waterway_vessel:destination:mss_objects_app:auto_country:delete',
        
        # Страна вывоза
        'objects:inland_waterway_vessel:destination:mss_objects_app:auto_country_export:delete',
        
        # Серия, номер ГТД
        'objects:inland_waterway_vessel:destination:mss_objects_app:gdt_ser_num:delete',
        
        # Таможенные ограничения
        'objects:inland_waterway_vessel:destination:mss_objects_app:auto_tam_ogr:delete',
        
        # Организация, выдавшая ПТС
        'objects:inland_waterway_vessel:destination:mss_objects_app:auto_pts_org:delete',
        
        # Дата ПТС
        'objects:inland_waterway_vessel:destination:mss_objects_app:data_pts:delete',
        
        # Отделение ГИБДД
        'objects:inland_waterway_vessel:destination:mss_objects_app:ps_gibdd:delete',

        ###
        # Удаление основного объекта
        'objects:inland_waterway_vessel:destination:mss_objects:delete',

         # Удаление дополнительных колонок
        'objects:inland_waterway_vessel:destination:mss_objects:drop___type_transport',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___link_type_transport',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___automaker',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___link_automaker',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___color_kuzov',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___link_color_kuzov',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___engine_type',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___link_engine_type',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___auto_country',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___link_auto_country',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___auto_country_export',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___link_auto_country_export',
      ]
    end
  end
end
