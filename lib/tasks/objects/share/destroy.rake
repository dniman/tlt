namespace :objects do
  namespace :share do
    namespace :destroy do
      task :tasks => [
        'objects:share:destination:___del_ids:insert',

        # История наименования
        'objects:share:destination:mss_objects_app:link_param:obj_name_hist:delete',

        # ID объекта из Сауми
        'objects:share:destination:mss_objects_app:link_param:id_obj:delete',
        
        # Старый реестровый номер
        'objects:share:destination:mss_objects_app:link_param:rn_old:delete',
        
        # Примечание 
        'objects:share:destination:mss_objects_app:link_param:note_obj:delete',
        
        # Первоначальная стоимость
        'objects:share:destination:mss_objects_app:link_param:price_first:delete',
        
        # Остаточная стоимость
        'objects:share:destination:mss_objects_app:link_param:price_remain:delete',
        
        # Состояние
        'objects:share:destination:mss_objects_app:link_param:state:delete',
        
        
        # Счет учета ОС
        'objects:share:destination:mss_objects_app:link_param:fixed_assets_account:delete',
        
        # Нормы амортизации
        'objects:share:destination:mss_objects_app:object:mss_depre_rates:delete',
        
        # Амортизационные группы
        'objects:share:destination:mss_objects_app:object:mss_depre_groups:delete',
        
        # Дата начала начисления амортизации
        'objects:share:destination:mss_objects_app:object:mss_od_date_begin_depre:delete',
        
        # Амортизация до принятия к учету
        'objects:share:destination:mss_objects_app:object:mss_od_depre_init_cost:delete',
        
        # Метод начисления амортизации 
        'objects:share:destination:mss_objects_app:object:mss_od_depre_method:delete',
        
        # Оставшийся срок полезного использования в месяцах 
        'objects:share:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:delete',
        
        # Оставшийся срок полезного использования в годах
        'objects:share:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:delete',


        # Удалим ссылку на тип Хозяйственное общество или товарищество 
        'objects:share:destination:t_corr_dict:reference_corr_type:emmitstock:delete',

        # Удаление основного объекта
        'objects:share:destination:mss_objects:delete',
        'objects:share:destination:___del_ids:delete',
        
        # Удаление доп колонок
        'objects:share:source:states:drop___link_state',
      ]
    end
  end
end
