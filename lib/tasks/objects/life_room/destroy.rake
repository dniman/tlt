namespace :objects do
  namespace :life_room do
    namespace :destroy do
      task :tasks => [
        # История адреса
        'objects:life_room:destination:mss_objects_app:link_param:add_hist:delete',
        
        # История наименования
        'objects:life_room:destination:mss_objects_app:link_param:obj_name_hist:delete',

        # Официальный адрес 
        'objects:life_room:destination:mss_objects_app:link_param:adr_str:delete',
        
        # Общая площадь
        'objects:life_room:destination:mss_objects_app:link_param:house_pl:delete',

        # ID объекта из Сауми
        'objects:life_room:destination:mss_objects_app:link_param:id_obj:delete',
        
        # Код ОКОФ
        'objects:life_room:destination:mss_objects_app:link_param:okof:delete',
        
        # Инвентарный номер
        'objects:life_room:destination:mss_objects_app:link_param:hous_inv_n:delete',
        
        # Год ввода в эксплуатацию 
        'objects:life_room:destination:mss_objects_app:link_param:year_vvod:delete',
        
        # Дата ввода в эксплуатацию 
        'objects:life_room:destination:mss_objects_app:link_param:house_date_begin_use:delete',
        
        # Материал стен
        'objects:life_room:destination:mss_objects_app:link_param:house_wall_type:delete',

        # Литера БТИ
        'objects:life_room:destination:mss_objects_app:link_param:bti_liter:delete',
        
        # Является недвижимым имуществом
        'objects:life_room:destination:mss_objects_app:link_param:is_immovable:delete',

        # Этажность
        'objects:life_room:destination:mss_objects_app:link_param:house_flats:delete',

        # знаковый объект
        'objects:life_room:destination:mss_objects_app:link_param:wow_obj:delete',
       
        # социально-значимый объект
        'objects:life_room:destination:mss_objects_app:link_param:soc_zn_obj:delete',

        # объект жкх 
        'objects:life_room:destination:mss_objects_app:link_param:obj_zkx:delete',

        # вид объекта жкх
        'objects:life_room:destination:mss_objects_app:link_param:vid_obj_zkx:delete',
        
        # Электроэнергия
        'objects:life_room:destination:mss_objects_app:link_param:blag_energ:delete',
        
        # Вода
        'objects:life_room:destination:mss_objects_app:link_param:blag_water:delete',
        
        # Газ 
        'objects:life_room:destination:mss_objects_app:link_param:blag_gaz:delete',
        
        # Канализация
        'objects:life_room:destination:mss_objects_app:link_param:blag_kan:delete',
        
        # Лифт
        'objects:life_room:destination:mss_objects_app:link_param:blag_lift:delete',
        
        # Мусоропровод 
        'objects:life_room:destination:mss_objects_app:link_param:blag_mus:delete',
        
        # Отопление
        'objects:life_room:destination:mss_objects_app:link_param:blag_hot:delete',
        
        # Телевидение
        'objects:life_room:destination:mss_objects_app:link_param:blag_tv:delete',
        
        # Телефонизация
        'objects:life_room:destination:mss_objects_app:link_param:blag_tel:delete',
        
        # Вентиляция
        'objects:life_room:destination:mss_objects_app:link_param:blag_vent:delete',
        
        # Памятник 
        'objects:life_room:destination:mss_objects_app:link_param:is_monument:delete',
        
        # Категория историко-культурного значения
        'objects:life_room:destination:mss_objects_app:link_param:culturial_sense:delete',

        # Наименование памятника
        'objects:life_room:destination:mss_objects_app:link_param:name_monument:delete',
 
        # Дополнительная информация о памятнике
        'objects:life_room:destination:mss_objects_app:link_param:other_monument:delete',

        # Старый реестровый номер
        'objects:life_room:destination:mss_objects_app:link_param:rn_old:delete',
        
        # Примечание 
        'objects:life_room:destination:mss_objects_app:link_param:note_obj:delete',
        
        # Назначение 
        'objects:life_room:destination:mss_objects_app:link_param:unmovable_used:delete',

        # Жилая площадь
        'objects:life_room:destination:mss_objects_app:link_param:house_pl_gil:delete',

        # Кадастровая стоимость
        'objects:life_room:destination:mss_objects_app:link_param:kadastr_price:delete',
        
        # Первоначальная стоимость
        'objects:life_room:destination:mss_objects_app:link_param:price_first:delete',
        
        # Остаточная стоимость
        'objects:life_room:destination:mss_objects_app:link_param:price_remain:delete',
        
        # Процент износа
        'objects:life_room:destination:mss_objects_app:link_param:iznos:delete',

        # Состояние
        'objects:life_room:destination:mss_objects_app:link_param:state:delete',

        
        # Счет учета ОС
        'objects:life_room:destination:mss_objects_app:link_param:fixed_assets_account:delete',
        
        # Нормы амортизации
        'objects:life_room:destination:mss_objects_app:object:mss_depre_rates:delete',
        
        # Амортизационные группы
        'objects:life_room:destination:mss_objects_app:object:mss_depre_groups:delete',
        
        # Дата начала начисления амортизации
        'objects:life_room:destination:mss_objects_app:object:mss_od_date_begin_depre:delete',
        
        # Амортизация до принятия к учету
        'objects:life_room:destination:mss_objects_app:object:mss_od_depre_init_cost:delete',
        
        # Метод начисления амортизации 
        'objects:life_room:destination:mss_objects_app:object:mss_od_depre_method:delete',
        
        # Оставшийся срок полезного использования в месяцах 
        'objects:life_room:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:delete',
        
        # Оставшийся срок полезного использования в годах
        'objects:life_room:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:delete',


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
        'objects:life_room:source:states:drop___link_state',
      ]
    end
  end
end
