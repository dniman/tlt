namespace :objects do
  namespace :life_room do
    namespace :destroy do
      task :tasks => [
        # История адреса
        'objects:life_room:destination:mss_objects_app:add_hist:delete',
        
        # История наименования
        'objects:life_room:destination:mss_objects_app:obj_name_hist:delete',

        # Официальный адрес 
        'objects:life_room:destination:mss_objects_app:adr_str:delete',
        
        # Общая площадь
        'objects:life_room:destination:mss_objects_app:house_pl:delete',

        # ID объекта из Сауми
        'objects:life_room:destination:mss_objects_app:id_obj:delete',
        
        # Инвентарный номер
        'objects:life_room:destination:mss_objects_app:hous_inv_n:delete',
        
        # Год ввода в эксплуатацию 
        'objects:life_room:destination:mss_objects_app:year_vvod:delete',
        
        # Дата ввода в эксплуатацию 
        'objects:life_room:destination:mss_objects_app:house_date_begin_use:delete',
        
        # Материал стен
        'objects:life_room:destination:mss_objects_app:house_wall_type:delete',

        # Литера БТИ
        'objects:life_room:destination:mss_objects_app:bti_liter:delete',
        
        # Является недвижимым имуществом
        'objects:life_room:destination:mss_objects_app:is_immovable:delete',

        # Этажность
        'objects:life_room:destination:mss_objects_app:house_flats:delete',

        # знаковый объект
        'objects:life_room:destination:mss_objects_app:wow_obj:delete',
       
        # социально-значимый объект
        'objects:life_room:destination:mss_objects_app:soc_zn_obj:delete',

        # объект жкх 
        'objects:life_room:destination:mss_objects_app:obj_zkx:delete',

        # вид объекта жкх
        'objects:life_room:destination:mss_objects_app:vid_obj_zkx:delete',
        
        # Электроэнергия
        'objects:life_room:destination:mss_objects_app:blag_energ:delete',
        
        # Вода
        'objects:life_room:destination:mss_objects_app:blag_water:delete',
        
        # Газ 
        'objects:life_room:destination:mss_objects_app:blag_gaz:delete',
        
        # Канализация
        'objects:life_room:destination:mss_objects_app:blag_kan:delete',
        
        # Лифт
        'objects:life_room:destination:mss_objects_app:blag_lift:delete',
        
        # Мусоропровод 
        'objects:life_room:destination:mss_objects_app:blag_mus:delete',
        
        # Отопление
        'objects:life_room:destination:mss_objects_app:blag_hot:delete',
        
        # Телевидение
        'objects:life_room:destination:mss_objects_app:blag_tv:delete',
        
        # Телефонизация
        'objects:life_room:destination:mss_objects_app:blag_tel:delete',
        
        # Вентиляция
        'objects:life_room:destination:mss_objects_app:blag_vent:delete',
        
        # Памятник 
        'objects:life_room:destination:mss_objects_app:is_monument:delete',
        
        # Категория историко-культурного значения
        'objects:life_room:destination:mss_objects_app:culturial_sense:delete',

        # Наименование памятника
        'objects:life_room:destination:mss_objects_app:name_monument:delete',
 
        # Дополнительная информация о памятнике
        'objects:life_room:destination:mss_objects_app:other_monument:delete',

        # Старый реестровый номер
        'objects:life_room:destination:mss_objects_app:rn_old:delete',
        
        # Примечание 
        'objects:life_room:destination:mss_objects_app:note_obj:delete',
        
        # Назначение 
        'objects:life_room:destination:mss_objects_app:unmovable_used:delete',

        # Жилая площадь
        'objects:life_room:destination:mss_objects_app:house_pl_gil:delete',

        'objects:life_room:destination:mss_objects:delete',
        'objects:life_room:destination:mss_objects:drop___cad_quorter',
        'objects:life_room:destination:mss_objects:drop___kadastrno',
        'objects:life_room:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:life_room:destination:mss_objects_adr:delete',
        'objects:life_room:source:ids:drop___link_adr',
        'objects:life_room:destination:mss_adr:delete',
        
        'objects:life_room:source:ids:drop___add_hist',
        'objects:life_room:source:ids:drop___adr_str',
        
        'objects:life_room:destination:mss_objects:drop___house_wall_type',
        'objects:life_room:destination:mss_objects:drop___link_house_wall_type',
        'objects:life_room:destination:mss_objects:drop___is_immovable',
        'objects:life_room:destination:mss_objects:drop___link_is_immovable',
        'objects:life_room:destination:mss_objects:drop___wow_obj',
        'objects:life_room:destination:mss_objects:drop___link_wow_obj',
        'objects:life_room:destination:mss_objects:drop___soc_zn_obj',
        'objects:life_room:destination:mss_objects:drop___link_soc_zn_obj',
        'objects:life_room:destination:mss_objects:drop___obj_zkx',
        'objects:life_room:destination:mss_objects:drop___link_obj_zkx',
        'objects:life_room:destination:mss_objects:drop___vid_obj_zkx',
        'objects:life_room:destination:mss_objects:drop___link_vid_obj_zkx',
        'objects:life_room:destination:mss_objects:drop___culturial_sense',
        'objects:life_room:destination:mss_objects:drop___link_culturial_sense',
        'objects:life_room:destination:mss_objects:drop___unmovable_used',
        'objects:life_room:destination:mss_objects:drop___link_unmovable_used',
      ]
    end
  end
end
