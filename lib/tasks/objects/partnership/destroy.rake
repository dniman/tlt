namespace :objects do
  namespace :partnership do
    namespace :destroy do
      task :tasks => [
        # История наименования
        'objects:partnership:destination:mss_objects_app:link_param:obj_name_hist:delete',

        # ID объекта из Сауми
        'objects:partnership:destination:mss_objects_app:link_param:id_obj:delete',
        
        # Старый реестровый номер
        'objects:partnership:destination:mss_objects_app:link_param:rn_old:delete',
        
        # Примечание 
        'objects:partnership:destination:mss_objects_app:link_param:note_obj:delete',
        
        # Значение из справочника наименований
        #'objects:partnership:destination:mss_objects_app:link_param:dict_name:delete',
        
        # Группы
        #'objects:partnership:destination:mss_objects_app:link_param:group:delete',
        
        # Разделы
        #'objects:partnership:destination:mss_objects_app:link_param:section:delete',
        

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


        # Удаление основного объекта
        'objects:partnership:destination:mss_objects:delete',

         # Удаление дополнительных колонок
        #'objects:partnership:destination:mss_objects:drop___dict_name',
        #'objects:partnership:destination:mss_objects:drop___link_dict_name',
        #'objects:partnership:destination:mss_objects:drop___group',
        #'objects:partnership:destination:mss_objects:drop___link_group',
        #'objects:partnership:destination:mss_objects:drop___section',
        #'objects:partnership:destination:mss_objects:drop___link_section',
      ]
    end
  end
end
