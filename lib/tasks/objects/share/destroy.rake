namespace :objects do
  namespace :share do
    namespace :destroy do
      task :tasks => [
        # История наименования
        'objects:share:destination:mss_objects_app:obj_name_hist:delete',

        # ID объекта из Сауми
        'objects:share:destination:mss_objects_app:id_obj:delete',
        
        # Старый реестровый номер
        'objects:share:destination:mss_objects_app:rn_old:delete',
        
        # Примечание 
        'objects:share:destination:mss_objects_app:note_obj:delete',
        
        # Значение из справочника наименований
        #'objects:share:destination:mss_objects_app:dict_name:delete',
        
        # Группы
        #'objects:share:destination:mss_objects_app:group:delete',
        
        # Разделы
        #'objects:share:destination:mss_objects_app:section:delete',

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
