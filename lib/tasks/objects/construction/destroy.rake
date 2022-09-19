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
        
        # Год ввода в эксплуатацию 
        'objects:construction:destination:mss_objects_app:year_vvod:delete',
        
        # Дата ввода в эксплуатацию 
        'objects:construction:destination:mss_objects_app:house_date_begin_use:delete',
       
        # Материал
        'objects:construction:destination:mss_objects_app:house_material:delete',
        
        # Литера БТИ
        'objects:construction:destination:mss_objects_app:bti_liter:delete',
        
        # Объем
        'objects:construction:destination:mss_objects_app:capacity:delete',
        
        # Является недвижимым имуществом
        'objects:construction:destination:mss_objects_app:is_immovable:delete',
        
        # Этажность
        'objects:construction:destination:mss_objects_app:house_flats:delete',
       
        # знаковый объект
        'objects:land:destination:mss_objects_app:wow_obj:delete',
       
        # социально-значимый объект
        'objects:land:destination:mss_objects_app:soc_zn_obj:delete',

        # объект жкх 
        'objects:land:destination:mss_objects_app:obj_zkx:delete',

        # вид объекта жкх
        'objects:land:destination:mss_objects_app:vid_obj_zkx:delete',

        # Электроэнергия
        'objects:construction:destination:mss_objects_app:blag_energ:delete',
        
        # Вода
        'objects:construction:destination:mss_objects_app:blag_water:delete',
        
        # Газ 
        'objects:construction:destination:mss_objects_app:blag_gaz:delete',
        
        # Канализация
        'objects:construction:destination:mss_objects_app:blag_kan:delete',

        'objects:construction:destination:mss_objects:delete',
        'objects:construction:destination:mss_objects:drop___cad_quorter',
        'objects:construction:destination:mss_objects:drop___kadastrno',
        'objects:construction:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:construction:destination:mss_objects_adr:delete',
        'objects:construction:source:ids:drop___link_adr',
        'objects:construction:destination:mss_adr:delete',
        'objects:construction:destination:mss_objects:drop___house_material',
        'objects:construction:destination:mss_objects:drop___link_house_material',
        'objects:construction:destination:mss_objects:drop___is_immovable',
        'objects:construction:destination:mss_objects:drop___link_is_immovable',
      ]

    end
  end
end
