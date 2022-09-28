namespace :objects do
  namespace :houses_life do
    namespace :destroy do
      task :tasks => [
        # История адреса
        'objects:houses_life:destination:mss_objects_app:add_hist:delete',
        
        # История наименования
        'objects:houses_life:destination:mss_objects_app:obj_name_hist:delete',

        # Официальный адрес 
        'objects:houses_life:destination:mss_objects_app:adr_str:delete',
        
        # Общая площадь
        'objects:houses_life:destination:mss_objects_app:house_pl:delete',

        # ID объекта из Сауми
        'objects:houses_life:destination:mss_objects_app:id_obj:delete',
        
        # Инвентарный номер
        'objects:houses_life:destination:mss_objects_app:hous_inv_n:delete',
        
        # Год ввода в эксплуатацию 
        'objects:houses_life:destination:mss_objects_app:year_vvod:delete',
        
        # Дата ввода в эксплуатацию 
        'objects:houses_life:destination:mss_objects_app:house_date_begin_use:delete',
        
        # Материал
        'objects:houses_life:destination:mss_objects_app:house_material:delete',

        # Литера БТИ
        'objects:houses_life:destination:mss_objects_app:bti_liter:delete',
        
        # Является недвижимым имуществом
        'objects:houses_life:destination:mss_objects_app:is_immovable:delete',

        # Этажность
        'objects:houses_life:destination:mss_objects_app:house_flats:delete',

        # знаковый объект
        'objects:houses_life:destination:mss_objects_app:wow_obj:delete',
       
        # социально-значимый объект
        'objects:houses_life:destination:mss_objects_app:soc_zn_obj:delete',

        # объект жкх 
        'objects:houses_life:destination:mss_objects_app:obj_zkx:delete',

        # вид объекта жкх
        'objects:houses_life:destination:mss_objects_app:vid_obj_zkx:delete',
        
        # Электроэнергия
        'objects:houses_life:destination:mss_objects_app:blag_energ:delete',
        
        # Вода
        'objects:houses_life:destination:mss_objects_app:blag_water:delete',
        
        # Газ 
        'objects:houses_life:destination:mss_objects_app:blag_gaz:delete',
        
        # Канализация
        'objects:houses_life:destination:mss_objects_app:blag_kan:delete',
        
        # Лифт
        'objects:houses_life:destination:mss_objects_app:blag_lift:delete',
        
        # Мусоропровод 
        'objects:houses_life:destination:mss_objects_app:blag_mus:delete',
        
        # Отопление
        'objects:houses_life:destination:mss_objects_app:blag_hot:delete',
        
        # Телевидение
        'objects:houses_life:destination:mss_objects_app:blag_tv:delete',
        
        # Телефонизация
        'objects:houses_life:destination:mss_objects_app:blag_tel:delete',
        
        # Вентиляция
        'objects:houses_life:destination:mss_objects_app:blag_vent:delete',
        
        # Памятник 
        'objects:houses_life:destination:mss_objects_app:is_monument:delete',
        
        # Категория историко-культурного значения
        'objects:houses_life:destination:mss_objects_app:culturial_sense:delete',

        # Наименование памятника
        'objects:houses_life:destination:mss_objects_app:name_monument:delete',
 
        'objects:houses_life:destination:mss_objects:delete',
        'objects:houses_life:destination:mss_objects:drop___cad_quorter',
        'objects:houses_life:destination:mss_objects:drop___kadastrno',
        'objects:houses_life:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:houses_life:destination:mss_objects_adr:delete',
        'objects:houses_life:source:ids:drop___link_adr',
        'objects:houses_life:destination:mss_adr:delete',
        
        'objects:houses_life:source:ids:drop___add_hist',
        'objects:houses_life:source:ids:drop___adr_str',
        
        'objects:houses_life:destination:mss_objects:drop___house_material',
        'objects:houses_life:destination:mss_objects:drop___link_house_material',
        'objects:houses_life:destination:mss_objects:drop___is_immovable',
        'objects:houses_life:destination:mss_objects:drop___link_is_immovable',
        'objects:houses_life:destination:mss_objects:drop___wow_obj',
        'objects:houses_life:destination:mss_objects:drop___link_wow_obj',
        'objects:houses_life:destination:mss_objects:drop___soc_zn_obj',
        'objects:houses_life:destination:mss_objects:drop___link_soc_zn_obj',
        'objects:houses_life:destination:mss_objects:drop___obj_zkx',
        'objects:houses_life:destination:mss_objects:drop___link_obj_zkx',
        'objects:houses_life:destination:mss_objects:drop___vid_obj_zkx',
        'objects:houses_life:destination:mss_objects:drop___link_vid_obj_zkx',
        'objects:houses_life:destination:mss_objects:drop___culturial_sense',
        'objects:houses_life:destination:mss_objects:drop___link_culturial_sense',
      ]
    end
  end
end
