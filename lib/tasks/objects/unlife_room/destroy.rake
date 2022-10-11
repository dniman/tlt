namespace :objects do
  namespace :unlife_room do
    namespace :destroy do
      task :tasks => [
        # История адреса
        'objects:unlife_room:destination:mss_objects_app:link_param:add_hist:delete',
        
        # История наименования
        'objects:unlife_room:destination:mss_objects_app:link_param:obj_name_hist:delete',

        # Официальный адрес 
        'objects:unlife_room:destination:mss_objects_app:link_param:adr_str:delete',
        
        # Общая площадь
        'objects:unlife_room:destination:mss_objects_app:link_param:house_pl:delete',

        # ID объекта из Сауми
        'objects:unlife_room:destination:mss_objects_app:link_param:id_obj:delete',
        
        # Код ОКОФ
        'objects:unlife_room:destination:mss_objects_app:link_param:okof:delete',
        
        # Инвентарный номер
        'objects:unlife_room:destination:mss_objects_app:link_param:hous_inv_n:delete',
        
        # Год ввода в эксплуатацию 
        'objects:unlife_room:destination:mss_objects_app:link_param:year_vvod:delete',
        
        # Дата ввода в эксплуатацию 
        'objects:unlife_room:destination:mss_objects_app:link_param:house_date_begin_use:delete',
        
        # Материал стен
        'objects:unlife_room:destination:mss_objects_app:link_param:house_wall_type:delete',

        # Литера БТИ
        'objects:unlife_room:destination:mss_objects_app:link_param:bti_liter:delete',
        
        # Является недвижимым имуществом
        'objects:unlife_room:destination:mss_objects_app:link_param:is_immovable:delete',

        # Этажность
        'objects:unlife_room:destination:mss_objects_app:link_param:house_flats:delete',

        # знаковый объект
        'objects:unlife_room:destination:mss_objects_app:link_param:wow_obj:delete',
       
        # социально-значимый объект
        'objects:unlife_room:destination:mss_objects_app:link_param:soc_zn_obj:delete',

        # объект жкх 
        'objects:unlife_room:destination:mss_objects_app:link_param:obj_zkx:delete',

        # вид объекта жкх
        'objects:unlife_room:destination:mss_objects_app:link_param:vid_obj_zkx:delete',
        
        # Электроэнергия
        'objects:unlife_room:destination:mss_objects_app:link_param:blag_energ:delete',
        
        # Вода
        'objects:unlife_room:destination:mss_objects_app:link_param:blag_water:delete',
        
        # Газ 
        'objects:unlife_room:destination:mss_objects_app:link_param:blag_gaz:delete',
        
        # Канализация
        'objects:unlife_room:destination:mss_objects_app:link_param:blag_kan:delete',
        
        # Лифт
        'objects:unlife_room:destination:mss_objects_app:link_param:blag_lift:delete',
        
        # Мусоропровод 
        'objects:unlife_room:destination:mss_objects_app:link_param:blag_mus:delete',
        
        # Отопление
        'objects:unlife_room:destination:mss_objects_app:link_param:blag_hot:delete',
        
        # Телевидение
        'objects:unlife_room:destination:mss_objects_app:link_param:blag_tv:delete',
        
        # Телефонизация
        'objects:unlife_room:destination:mss_objects_app:link_param:blag_tel:delete',
        
        # Вентиляция
        'objects:unlife_room:destination:mss_objects_app:link_param:blag_vent:delete',
        
        # Памятник 
        'objects:unlife_room:destination:mss_objects_app:link_param:is_monument:delete',
        
        # Категория историко-культурного значения
        'objects:unlife_room:destination:mss_objects_app:link_param:culturial_sense:delete',

        # Наименование памятника
        'objects:unlife_room:destination:mss_objects_app:link_param:name_monument:delete',
 
        # Дополнительная информация о памятнике
        'objects:unlife_room:destination:mss_objects_app:link_param:other_monument:delete',

        # Старый реестровый номер
        'objects:unlife_room:destination:mss_objects_app:link_param:rn_old:delete',
        
        # Примечание 
        'objects:unlife_room:destination:mss_objects_app:link_param:note_obj:delete',
        
        # Назначение 
        'objects:unlife_room:destination:mss_objects_app:link_param:unmovable_used:delete',

        # Жилая площадь
        'objects:unlife_room:destination:mss_objects_app:link_param:house_pl_gil:delete',
        
        # Кадастровая стоимость
        'objects:unlife_room:destination:mss_objects_app:link_param:kadastr_price:delete',
        

        # Счет учета ОС
        'objects:unlife_room:destination:mss_objects_app:link_param:fixed_assets_account:delete',
        
        # Нормы амортизации
        'objects:unlife_room:destination:mss_objects_app:object:mss_depre_rates:delete',
        
        # Амортизационные группы
        'objects:unlife_room:destination:mss_objects_app:object:mss_depre_groups:delete',
        
        # Дата начала начисления амортизации
        'objects:unlife_room:destination:mss_objects_app:object:mss_od_date_begin_depre:delete',
        
        # Амортизация до принятия к учету
        'objects:unlife_room:destination:mss_objects_app:object:mss_od_depre_init_cost:delete',
        
        # Метод начисления амортизации 
        'objects:unlife_room:destination:mss_objects_app:object:mss_od_depre_method:delete',
        
        # Оставшийся срок полезного использования в месяцах 
        'objects:unlife_room:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:delete',
        
        # Оставшийся срок полезного использования в годах
        'objects:unlife_room:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:delete',


        'objects:unlife_room:destination:mss_objects:delete',
        'objects:unlife_room:destination:mss_objects:drop___cad_quorter',
        'objects:unlife_room:destination:mss_objects:drop___kadastrno',
        'objects:unlife_room:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:unlife_room:destination:mss_objects_adr:delete',
        'objects:unlife_room:source:ids:drop___link_adr',
        'objects:unlife_room:destination:mss_adr:delete',
        
        'objects:unlife_room:source:ids:drop___add_hist',
        'objects:unlife_room:source:ids:drop___adr_str',
        
        'objects:unlife_room:destination:mss_objects:drop___house_wall_type',
        'objects:unlife_room:destination:mss_objects:drop___link_house_wall_type',
        'objects:unlife_room:destination:mss_objects:drop___is_immovable',
        'objects:unlife_room:destination:mss_objects:drop___link_is_immovable',
        'objects:unlife_room:destination:mss_objects:drop___wow_obj',
        'objects:unlife_room:destination:mss_objects:drop___link_wow_obj',
        'objects:unlife_room:destination:mss_objects:drop___soc_zn_obj',
        'objects:unlife_room:destination:mss_objects:drop___link_soc_zn_obj',
        'objects:unlife_room:destination:mss_objects:drop___obj_zkx',
        'objects:unlife_room:destination:mss_objects:drop___link_obj_zkx',
        'objects:unlife_room:destination:mss_objects:drop___vid_obj_zkx',
        'objects:unlife_room:destination:mss_objects:drop___link_vid_obj_zkx',
        'objects:unlife_room:destination:mss_objects:drop___culturial_sense',
        'objects:unlife_room:destination:mss_objects:drop___link_culturial_sense',
        'objects:unlife_room:destination:mss_objects:drop___unmovable_used',
        'objects:unlife_room:destination:mss_objects:drop___link_unmovable_used',
      ]
    end
  end
end
