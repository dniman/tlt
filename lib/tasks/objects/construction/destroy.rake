namespace :objects do
  namespace :construction do
    namespace :destroy do

      task :tasks => [
        # История адреса
        'objects:construction:destination:mss_objects_app:add_hist:delete',
        
        # История наименования
        'objects:construction:destination:mss_objects_app:obj_name_hist:delete',

        # Официальный адрес 
        'objects:construction:destination:mss_objects_app:adr_str:delete',

        # Общая площадь
        'objects:construction:destination:mss_objects_app:house_pl:delete',

        # ID объекта из Сауми
        'objects:construction:destination:mss_objects_app:id_obj:delete',
        
        # Инвентарный номер
        'objects:construction:destination:mss_objects_app:hous_inv_n:delete',

        'objects:construction:destination:mss_objects:delete',
        'objects:construction:destination:mss_objects:drop___cad_quorter',
        'objects:construction:destination:mss_objects:drop___kadastrno',
        'objects:construction:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:construction:destination:mss_objects_adr:delete',
        'objects:construction:source:ids:drop___link_adr',
        'objects:construction:destination:mss_adr:delete',
      ]

    end
  end
end
