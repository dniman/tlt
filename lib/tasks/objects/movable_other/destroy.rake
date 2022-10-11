namespace :objects do
  namespace :movable_other do
    namespace :destroy do
      task :tasks => [
        # Адрес последнего местоположения
        'objects:movable_other:destination:mss_objects_app:link_param:last_loc_addr:delete',
        
        # История наименования
        'objects:movable_other:destination:mss_objects_app:link_param:obj_name_hist:delete',

        # ID объекта из Сауми
        'objects:movable_other:destination:mss_objects_app:link_param:id_obj:delete',
        
        # Старый реестровый номер
        'objects:movable_other:destination:mss_objects_app:link_param:rn_old:delete',
        
        # Примечание 
        'objects:movable_other:destination:mss_objects_app:link_param:note_obj:delete',
        
        # Значение из справочника наименований
        'objects:movable_other:destination:mss_objects_app:link_param:dict_name:delete',
        
        # Группы
        'objects:movable_other:destination:mss_objects_app:link_param:group:delete',
        
        # Разделы
        'objects:movable_other:destination:mss_objects_app:link_param:section:delete',
        
        # Первоначальная стоимость
        'objects:movable_other:destination:mss_objects_app:link_param:price_first:delete',
        
        # Остаточная стоимость
        'objects:movable_other:destination:mss_objects_app:link_param:price_remain:delete',
        
        # Процент износа
        'objects:movable_other:destination:mss_objects_app:link_param:iznos:delete',
        

        # Счет учета ОС
        'objects:movable_other:destination:mss_objects_app:link_param:fixed_assets_account:delete',
        
        # Нормы амортизации
        'objects:movable_other:destination:mss_objects_app:object:mss_depre_rates:delete',
        
        # Амортизационные группы
        'objects:movable_other:destination:mss_objects_app:object:mss_depre_groups:delete',
        
        # Дата начала начисления амортизации
        'objects:movable_other:destination:mss_objects_app:object:mss_od_date_begin_depre:delete',
        
        # Амортизация до принятия к учету
        'objects:movable_other:destination:mss_objects_app:object:mss_od_depre_init_cost:delete',
        
        # Метод начисления амортизации 
        'objects:movable_other:destination:mss_objects_app:object:mss_od_depre_method:delete',
        
        # Оставшийся срок полезного использования в месяцах 
        'objects:movable_other:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:delete',
        
        # Оставшийся срок полезного использования в годах
        'objects:movable_other:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:delete',


        # Удаление основного объекта
        'objects:movable_other:destination:mss_objects:delete',

         # Удаление дополнительных колонок
        'objects:movable_other:source:ids:drop___last_loc_addr',
        'objects:movable_other:destination:mss_objects:drop___dict_name',
        'objects:movable_other:destination:mss_objects:drop___link_dict_name',
        'objects:movable_other:destination:mss_objects:drop___group',
        'objects:movable_other:destination:mss_objects:drop___link_group',
        'objects:movable_other:destination:mss_objects:drop___section',
        'objects:movable_other:destination:mss_objects:drop___link_section',
      ]
    end
  end
end
