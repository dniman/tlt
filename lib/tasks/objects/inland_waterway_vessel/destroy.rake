namespace :objects do
  namespace :inland_waterway_vessel do
    namespace :destroy do
      task :tasks => [
        # История наименования
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:obj_name_hist:delete',
        
        # История инвентарного номера
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:obj_invnum_hist:delete',

        # ID объекта из Сауми
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:id_obj:delete',
        
        # Код ОКОФ
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:okof:delete',
        
        # Старый реестровый номер
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:rn_old:delete',
        
        # Примечание 
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:note_obj:delete',
        
        # Модель транспортного средства
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:movable_model:delete',
        
        # Год выпуска
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:movable_year:delete',
        
        # Государственный регистрационный номер
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:vessel_reg_num:delete',
        
        # Номер двигателя
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:dvigat_num:delete',
        
        # Номер кузова
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:kuzov_num:delete',

        # Тип транспорта
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:type_transport:delete',
        
        # Марка транспортного средства
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:automaker:delete',
        
        # Мощность двигателя
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:power_dvig:delete',
        
        # Объем двигателя
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:v_dvigatel:delete',
        
        # Тип двигателя
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:engine_type:delete',
        
        # Разрешенная максимальная масса
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:razresh_max_mas:delete',
        
        # Масса без нагрузки
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:mass_without_load:delete',
        
        # Изготовитель(страна)
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:auto_country:delete',
        
        # Первоначальная стоимость
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:price_first:delete',


        # Счет учета ОС
        'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:fixed_assets_account:delete',
        
        # Нормы амортизации
        'objects:inland_waterway_vessel:destination:mss_objects_app:object:mss_depre_rates:delete',
        
        # Амортизационные группы
        'objects:inland_waterway_vessel:destination:mss_objects_app:object:mss_depre_groups:delete',
        
        # Дата начала начисления амортизации
        'objects:inland_waterway_vessel:destination:mss_objects_app:object:mss_od_date_begin_depre:delete',
        
        # Амортизация до принятия к учету
        'objects:inland_waterway_vessel:destination:mss_objects_app:object:mss_od_depre_init_cost:delete',
        
        # Метод начисления амортизации 
        'objects:inland_waterway_vessel:destination:mss_objects_app:object:mss_od_depre_method:delete',
        
        # Оставшийся срок полезного использования в месяцах 
        'objects:inland_waterway_vessel:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:delete',
        
        # Оставшийся срок полезного использования в годах
        'objects:inland_waterway_vessel:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:delete',

        # Удаление основного объекта
        'objects:inland_waterway_vessel:destination:mss_objects:delete',

         # Удаление дополнительных колонок
        'objects:inland_waterway_vessel:destination:mss_objects:drop___type_transport',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___link_type_transport',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___automaker',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___link_automaker',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___engine_type',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___link_engine_type',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___auto_country',
        'objects:inland_waterway_vessel:destination:mss_objects:drop___link_auto_country',
      ]
    end
  end
end
