namespace :objects do
  namespace :share do
    namespace :destroy do
      task :tasks => [
        # История наименования
        'objects:share:destination:mss_objects_app:link_param:obj_name_hist:delete',

        # ID объекта из Сауми
        'objects:share:destination:mss_objects_app:link_param:id_obj:delete',
        
        # Старый реестровый номер
        'objects:share:destination:mss_objects_app:link_param:rn_old:delete',
        
        # Примечание 
        'objects:share:destination:mss_objects_app:link_param:note_obj:delete',
        
        # Значение из справочника наименований
        #'objects:share:destination:mss_objects_app:link_param:dict_name:delete',
        
        # Группы
        #'objects:share:destination:mss_objects_app:link_param:group:delete',
        
        # Разделы
        #'objects:share:destination:mss_objects_app:link_param:section:delete',
        

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


        # Удаление основного объекта
        'objects:share:destination:mss_objects:delete',

         # Удаление дополнительных колонок
        #'objects:share:destination:mss_objects:drop___dict_name',
        #'objects:share:destination:mss_objects:drop___link_dict_name',
        #'objects:share:destination:mss_objects:drop___group',
        #'objects:share:destination:mss_objects:drop___link_group',
        #'objects:share:destination:mss_objects:drop___section',
        #'objects:share:destination:mss_objects:drop___link_section',
      ]
    end
  end
end
