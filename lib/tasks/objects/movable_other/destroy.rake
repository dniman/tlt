namespace :objects do
  namespace :movable_other do
    namespace :destroy do
      task :tasks => [
        # История адреса
        'objects:movable_other:destination:mss_objects_app:add_hist:delete',
        
        # История наименования
        'objects:movable_other:destination:mss_objects_app:obj_name_hist:delete',

        # Официальный адрес 
        'objects:movable_other:destination:mss_objects_app:adr_str:delete',
        
        # Общая площадь
        'objects:movable_other:destination:mss_objects_app:house_pl:delete',

        # ID объекта из Сауми
        'objects:movable_other:destination:mss_objects_app:id_obj:delete',
        
        # Инвентарный номер
        'objects:movable_other:destination:mss_objects_app:hous_inv_n:delete',
        
        # Год ввода в эксплуатацию 
        'objects:movable_other:destination:mss_objects_app:year_vvod:delete',
        
        # Дата ввода в эксплуатацию 
        'objects:movable_other:destination:mss_objects_app:house_date_begin_use:delete',
        
        # Материал стен
        'objects:movable_other:destination:mss_objects_app:house_wall_type:delete',

        # Литера БТИ
        'objects:movable_other:destination:mss_objects_app:bti_liter:delete',
        
        # Является недвижимым имуществом
        'objects:movable_other:destination:mss_objects_app:is_immovable:delete',

        # Этажность
        'objects:movable_other:destination:mss_objects_app:house_flats:delete',

        # знаковый объект
        'objects:movable_other:destination:mss_objects_app:wow_obj:delete',
       
        # социально-значимый объект
        'objects:movable_other:destination:mss_objects_app:soc_zn_obj:delete',

        # объект жкх 
        'objects:movable_other:destination:mss_objects_app:obj_zkx:delete',

        # вид объекта жкх
        'objects:movable_other:destination:mss_objects_app:vid_obj_zkx:delete',
        
        # Электроэнергия
        'objects:movable_other:destination:mss_objects_app:blag_energ:delete',
        
        # Вода
        'objects:movable_other:destination:mss_objects_app:blag_water:delete',
        
        # Газ 
        'objects:movable_other:destination:mss_objects_app:blag_gaz:delete',
        
        # Канализация
        'objects:movable_other:destination:mss_objects_app:blag_kan:delete',
        
        # Лифт
        'objects:movable_other:destination:mss_objects_app:blag_lift:delete',
        
        # Мусоропровод 
        'objects:movable_other:destination:mss_objects_app:blag_mus:delete',
        
        # Отопление
        'objects:movable_other:destination:mss_objects_app:blag_hot:delete',
        
        # Телевидение
        'objects:movable_other:destination:mss_objects_app:blag_tv:delete',
        
        # Телефонизация
        'objects:movable_other:destination:mss_objects_app:blag_tel:delete',
        
        # Вентиляция
        'objects:movable_other:destination:mss_objects_app:blag_vent:delete',
        
        # Памятник 
        'objects:movable_other:destination:mss_objects_app:is_monument:delete',
        
        # Категория историко-культурного значения
        'objects:movable_other:destination:mss_objects_app:culturial_sense:delete',

        # Наименование памятника
        'objects:movable_other:destination:mss_objects_app:name_monument:delete',
 
        # Дополнительная информация о памятнике
        'objects:movable_other:destination:mss_objects_app:other_monument:delete',

        # Старый реестровый номер
        'objects:movable_other:destination:mss_objects_app:rn_old:delete',
        
        # Примечание 
        'objects:movable_other:destination:mss_objects_app:note_obj:delete',
        
        # Назначение 
        'objects:movable_other:destination:mss_objects_app:unmovable_used:delete',

        # Жилая площадь
        'objects:movable_other:destination:mss_objects_app:house_pl_gil:delete',

        'objects:movable_other:destination:mss_objects:delete',
        'objects:movable_other:destination:mss_objects:drop___cad_quorter',
        'objects:movable_other:destination:mss_objects:drop___kadastrno',
        'objects:movable_other:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:movable_other:destination:mss_objects_adr:delete',
        'objects:movable_other:source:ids:drop___link_adr',
        'objects:movable_other:destination:mss_adr:delete',
        
        'objects:movable_other:source:ids:drop___add_hist',
        'objects:movable_other:source:ids:drop___adr_str',
        
        'objects:movable_other:destination:mss_objects:drop___house_wall_type',
        'objects:movable_other:destination:mss_objects:drop___link_house_wall_type',
        'objects:movable_other:destination:mss_objects:drop___is_immovable',
        'objects:movable_other:destination:mss_objects:drop___link_is_immovable',
        'objects:movable_other:destination:mss_objects:drop___wow_obj',
        'objects:movable_other:destination:mss_objects:drop___link_wow_obj',
        'objects:movable_other:destination:mss_objects:drop___soc_zn_obj',
        'objects:movable_other:destination:mss_objects:drop___link_soc_zn_obj',
        'objects:movable_other:destination:mss_objects:drop___obj_zkx',
        'objects:movable_other:destination:mss_objects:drop___link_obj_zkx',
        'objects:movable_other:destination:mss_objects:drop___vid_obj_zkx',
        'objects:movable_other:destination:mss_objects:drop___link_vid_obj_zkx',
        'objects:movable_other:destination:mss_objects:drop___culturial_sense',
        'objects:movable_other:destination:mss_objects:drop___link_culturial_sense',
        'objects:movable_other:destination:mss_objects:drop___unmovable_used',
        'objects:movable_other:destination:mss_objects:drop___link_unmovable_used',
      ]
    end
  end
end
