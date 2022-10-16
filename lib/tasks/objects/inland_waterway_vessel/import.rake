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
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:obj_name_hist:insert'
        
        # История инвентарного номера
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:obj_invnum_hist:insert'
        
        # ID объекта из Сауми
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:id_obj:insert'
        
        # Код ОКОФ
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:okof:insert'
        
        # Старый реестровый номер
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:rn_old:insert'
        
        # Примечание 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:note_obj:insert'
        
        # Модель транспортного средства
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:movable_model:insert'
        
        # Год выпуска
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:movable_year:insert'
        
        # Государственный регистрационный номер
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:vessel_reg_num:insert'
        
        # Номер двигателя
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:dvigat_num:insert'
        
        # Номер кузова
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:kuzov_num:insert'
        
        # Тип транспорта
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:add___link_type_transport' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:update___link_type_transport' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:type_transport:insert'
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:drop___type_transport' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:drop___link_type_transport' 
        
        # Марка транспортного средства
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:add___link_automaker' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:update___link_automaker' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:automaker:insert'
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:drop___automaker' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:drop___link_automaker' 
        
        # Мощность двигателя
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:power_dvig:insert'
        
        # Объем двигателя
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:v_dvigatel:insert'
        
        # Тип двигателя
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:add___link_engine_type' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:update___link_engine_type' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:engine_type:insert'
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:drop___engine_type' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:drop___link_engine_type' 
        
        # Разрешенная максимальная масса
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:razresh_max_mas:insert'
        
        # Масса без нагрузки
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:mass_without_load:insert'
        
        # Изготовитель(страна)
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:add___link_auto_country' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:update___link_auto_country' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:auto_country:insert'
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:drop___auto_country' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects:drop___link_auto_country' 
        
        # Первоначальная стоимость
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:price_first:insert'
        
        # Остаточная стоимость
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:price_remain:insert'
        
        # Процент износа
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:iznos:insert'
        
        # Состояние
        Rake.invoke_task 'objects:inland_waterway_vessel:source:states:add___link_state' 
        Rake.invoke_task 'objects:inland_waterway_vessel:source:states:update___link_state' 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:state:insert'
        Rake.invoke_task 'objects:inland_waterway_vessel:source:states:drop___link_state' 

        
        # Счет учета ОС
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:link_param:fixed_assets_account:insert'
        
        # Нормы амортизации
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:object:mss_depre_rates:insert'

        # Амортизационные группы
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:object:mss_depre_groups:insert'
        
        # Дата начала начисления амортизации
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:object:mss_od_date_begin_depre:insert'
        
        # Амортизация до принятия к учету
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:object:mss_od_depre_init_cost:insert'
        
        # Метод начисления амортизации 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:object:mss_od_depre_method:insert'
        
        # Оставшийся срок полезного использования в месяцах 
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:insert'
        
        # Оставшийся срок полезного использования в годах
        Rake.invoke_task 'objects:inland_waterway_vessel:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:insert'
      end 

    end
  end
end
