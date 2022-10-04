namespace :objects do
  namespace :exright_intellprop do
    namespace :destroy do
      task :tasks => [
        # История наименования
        'objects:exright_intellprop:destination:mss_objects_app:obj_name_hist:delete',

        # ID объекта из Сауми
        'objects:exright_intellprop:destination:mss_objects_app:id_obj:delete',
        
        # Старый реестровый номер
        'objects:exright_intellprop:destination:mss_objects_app:rn_old:delete',
        
        # Примечание 
        'objects:exright_intellprop:destination:mss_objects_app:note_obj:delete',
        
        # Значение из справочника наименований
        #'objects:exright_intellprop:destination:mss_objects_app:dict_name:delete',
        
        # Группы
        #'objects:exright_intellprop:destination:mss_objects_app:group:delete',
        
        # Разделы
        #'objects:exright_intellprop:destination:mss_objects_app:section:delete',

        # Удаление основного объекта
        'objects:exright_intellprop:destination:mss_objects:delete',

         # Удаление дополнительных колонок
        #'objects:exright_intellprop:destination:mss_objects:drop___dict_name',
        #'objects:exright_intellprop:destination:mss_objects:drop___link_dict_name',
        #'objects:exright_intellprop:destination:mss_objects:drop___group',
        #'objects:exright_intellprop:destination:mss_objects:drop___link_group',
        #'objects:exright_intellprop:destination:mss_objects:drop___section',
        #'objects:exright_intellprop:destination:mss_objects:drop___link_section',
      ]
    end
  end
end