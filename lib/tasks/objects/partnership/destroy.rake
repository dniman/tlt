namespace :objects do
  namespace :partnership do
    namespace :destroy do
      task :tasks => [
        'objects:partnership:destination:___del_ids:insert',

        # История наименования
        'objects:partnership:destination:mss_objects_app:link_param:obj_name_hist:delete',

        # ID объекта из Сауми
        'objects:partnership:destination:mss_objects_app:link_param:id_obj:delete',
        
        # Старый реестровый номер
        'objects:partnership:destination:mss_objects_app:link_param:rn_old:delete',
        
        # Примечание 
        'objects:partnership:destination:mss_objects_app:link_param:note_obj:delete',
        
        # Первоначальная стоимость
        'objects:partnership:destination:mss_objects_app:link_param:price_first:delete',
        
        # Остаточная стоимость
        'objects:partnership:destination:mss_objects_app:link_param:price_remain:delete',
        
        # Состояние
        'objects:partnership:destination:mss_objects_app:link_param:state:delete',
        
        # Доля в уставном капитале
        'objects:partnership:destination:mss_objects_app:link_param:capital_share:delete',
        
        # Доля, руб
        'objects:partnership:destination:mss_objects_app:link_param:share_rub:delete',

        
        # Счет учета ОС
        'objects:partnership:destination:mss_objects_app:link_param:fixed_assets_account:delete',
        
        # Нормы амортизации
        'objects:partnership:destination:mss_objects_app:object:mss_depre_rates:delete',
        
        # Амортизационные группы
        'objects:partnership:destination:mss_objects_app:object:mss_depre_groups:delete',
        
        # Дата начала начисления амортизации
        'objects:partnership:destination:mss_objects_app:object:mss_od_date_begin_depre:delete',
        
        # Амортизация до принятия к учету
        'objects:partnership:destination:mss_objects_app:object:mss_od_depre_init_cost:delete',
        
        # Метод начисления амортизации 
        'objects:partnership:destination:mss_objects_app:object:mss_od_depre_method:delete',
        
        # Оставшийся срок полезного использования в месяцах 
        'objects:partnership:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:delete',
        
        # Оставшийся срок полезного использования в годах
        'objects:partnership:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:delete',

        # Удалим ссылку на тип Хозяйственное общество или товарищество 
        'objects:partnership:destination:t_corr_dict:reference_corr_type:partnership:delete',
        
        # Документы
        'objects:partnership:destination:mss_detail_list:delete',
        'objects:partnership:source:___ids:drop___link_list',

        # Удаление основного объекта
        'objects:partnership:destination:mss_objects:delete',
        'objects:partnership:destination:___del_ids:delete',
        
        # Удаление доп колонок
        'objects:partnership:source:states:drop___link_state',
      ]
    end
  end
end
