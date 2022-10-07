namespace :objects do
  namespace :transport do
    namespace :destroy do
      task :tasks => [
        # История наименования
        'objects:transport:destination:mss_objects_app:link_param:obj_name_hist:delete',
        
        # История инвентарного номера
        'objects:transport:destination:mss_objects_app:link_param:obj_invnum_hist:delete',

        # ID объекта из Сауми
        'objects:transport:destination:mss_objects_app:link_param:id_obj:delete',

        # Код ОКОФ
        'objects:transport:destination:mss_objects_app:link_param:okof:delete',
        
        # Старый реестровый номер
        'objects:transport:destination:mss_objects_app:link_param:rn_old:delete',
        
        # Примечание 
        'objects:transport:destination:mss_objects_app:link_param:note_obj:delete',
        
        # Модель транспортного средства
        'objects:transport:destination:mss_objects_app:link_param:movable_model:delete',
        
        # Год выпуска
        'objects:transport:destination:mss_objects_app:link_param:movable_year:delete',
        
        # Государственный регистрационный номер
        'objects:transport:destination:mss_objects_app:link_param:transport_reg_n:delete',
        
        # Номер двигателя
        'objects:transport:destination:mss_objects_app:link_param:dvigat_num:delete',
        
        # Номер шасси(рамы) 
        'objects:transport:destination:mss_objects_app:link_param:shassi_num:delete',

        # Номер кузова
        'objects:transport:destination:mss_objects_app:link_param:kuzov_num:delete',

        # Тип транспорта
        'objects:transport:destination:mss_objects_app:link_param:type_transport:delete',
        
        # Марка транспортного средства
        'objects:transport:destination:mss_objects_app:link_param:automaker:delete',
        
        # Идентификационный номер(VIN)
        'objects:transport:destination:mss_objects_app:link_param:vin_num:delete',
        
        # Цвет кузова
        'objects:transport:destination:mss_objects_app:link_param:color_kuzov:delete',
        
        # Мощность двигателя
        'objects:transport:destination:mss_objects_app:link_param:power_dvig:delete',
        
        # Объем двигателя
        'objects:transport:destination:mss_objects_app:link_param:v_dvigatel:delete',
        
        # Тип двигателя
        'objects:transport:destination:mss_objects_app:link_param:engine_type:delete',
        
        # Разрешенная максимальная масса
        'objects:transport:destination:mss_objects_app:link_param:razresh_max_mas:delete',
        
        # Масса без нагрузки
        'objects:transport:destination:mss_objects_app:link_param:mass_without_load:delete',
        
        # Изготовитель(страна)
        'objects:transport:destination:mss_objects_app:link_param:auto_country:delete',
        
        # Страна вывоза
        'objects:transport:destination:mss_objects_app:link_param:auto_country_export:delete',
        
        # Серия, номер ГТД
        'objects:transport:destination:mss_objects_app:link_param:gdt_ser_num:delete',
        
        # Таможенные ограничения
        'objects:transport:destination:mss_objects_app:link_param:auto_tam_ogr:delete',
        
        # Организация, выдавшая ПТС
        'objects:transport:destination:mss_objects_app:link_param:auto_pts_org:delete',
        
        # Дата ПТС
        'objects:transport:destination:mss_objects_app:link_param:data_pts:delete',
        
        # Отделение ГИБДД
        'objects:transport:destination:mss_objects_app:link_param:ps_gibdd:delete',

        # Счет учета ОС
        'objects:transport:destination:mss_objects_app:link_param:fixed_assets_account:delete',
        
        # Нормы амортизации
        'objects:transport:destination:mss_objects_app:object:mss_depre_rates:delete',
        
        # Амортизационные группы
        'objects:transport:destination:mss_objects_app:object:mss_depre_groups:delete',
        
        # Дата начала начисления амортизации
        'objects:transport:destination:mss_objects_app:object:mss_od_date_begin_depre:delete',
        
        # Амортизация до принятия к учету
        'objects:transport:destination:mss_objects_app:object:mss_od_depre_init_cost:delete',
        
        # Метод начисления амортизации 
        'objects:transport:destination:mss_objects_app:object:mss_od_depre_method:delete',
        
        # Оставшийся срок полезного использования в месяцах 
        'objects:transport:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:delete',
        
        # Оставшийся срок полезного использования в годах
        'objects:transport:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:delete',

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
        'objects:transport:destination:mss_objects:drop___auto_country',
        'objects:transport:destination:mss_objects:drop___link_auto_country',
        'objects:transport:destination:mss_objects:drop___auto_country_export',
        'objects:transport:destination:mss_objects:drop___link_auto_country_export',
      ]
    end
  end
end
