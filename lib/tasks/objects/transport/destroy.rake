namespace :objects do
  namespace :transport do
    namespace :destroy do
      task :tasks => [
        # История наименования
        'objects:transport:destination:mss_objects_app:obj_name_hist:delete',

        # ID объекта из Сауми
        'objects:transport:destination:mss_objects_app:id_obj:delete',
        
        # Старый реестровый номер
        'objects:transport:destination:mss_objects_app:rn_old:delete',
        
        # Примечание 
        'objects:transport:destination:mss_objects_app:note_obj:delete',
        
        # Значение из справочника наименований
        #'objects:transport:destination:mss_objects_app:dict_name:delete',
        
        # Группы
        #'objects:transport:destination:mss_objects_app:group:delete',
        
        # Разделы
        #'objects:transport:destination:mss_objects_app:section:delete',

        # Удаление основного объекта
        'objects:transport:destination:mss_objects:delete',

         # Удаление дополнительных колонок
        #'objects:transport:destination:mss_objects:drop___dict_name',
        #'objects:transport:destination:mss_objects:drop___link_dict_name',
        #'objects:transport:destination:mss_objects:drop___group',
        #'objects:transport:destination:mss_objects:drop___link_group',
        #'objects:transport:destination:mss_objects:drop___section',
        #'objects:transport:destination:mss_objects:drop___link_section',
      ]
    end
  end
end
