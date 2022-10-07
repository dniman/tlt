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
