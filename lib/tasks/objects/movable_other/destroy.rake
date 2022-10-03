namespace :objects do
  namespace :movable_other do
    namespace :destroy do
      task :tasks => [
        # Адрес последнего местоположения
        'objects:movable_other:destination:mss_objects_app:last_loc_addr:delete',
        
        # История наименования
        'objects:movable_other:destination:mss_objects_app:obj_name_hist:delete',

        # ID объекта из Сауми
        'objects:movable_other:destination:mss_objects_app:id_obj:delete',
        
        # Старый реестровый номер
        'objects:movable_other:destination:mss_objects_app:rn_old:delete',
        
        # Примечание 
        'objects:movable_other:destination:mss_objects_app:note_obj:delete',
        
        # Удаление основного объекта
        'objects:movable_other:destination:mss_objects:delete',

        'objects:life_room:source:ids:drop___last_loc_addr',
      ]
    end
  end
end
