namespace :objects do
  namespace :unfinished do
    namespace :destroy do
      task :tasks => [
        # История адреса
        'objects:unfinished:destination:mss_objects_app:link_param:add_hist:delete',
        
        # История наименования
        'objects:unfinished:destination:mss_objects_app:link_param:obj_name_hist:delete',

        # Официальный адрес 
        'objects:unfinished:destination:mss_objects_app:link_param:adr_str:delete',
        
        # Общая площадь
        'objects:unfinished:destination:mss_objects_app:link_param:house_pl:delete',

        # ID объекта из Сауми
        'objects:unfinished:destination:mss_objects_app:link_param:id_obj:delete',
        
        # Код ОКОФ
        'objects:unfinished:destination:mss_objects_app:link_param:okof:delete',
        
        # Инвентарный номер
        'objects:unfinished:destination:mss_objects_app:link_param:hous_inv_n:delete',
        
        # Год ввода в эксплуатацию 
        'objects:unfinished:destination:mss_objects_app:link_param:year_vvod:delete',
        
        # Дата ввода в эксплуатацию 
        'objects:unfinished:destination:mss_objects_app:link_param:house_date_begin_use:delete',
        
        # Материал стен
        'objects:unfinished:destination:mss_objects_app:link_param:house_wall_type:delete',

        # Литера БТИ
        'objects:unfinished:destination:mss_objects_app:link_param:bti_liter:delete',
        
        # Является недвижимым имуществом
        'objects:unfinished:destination:mss_objects_app:link_param:is_immovable:delete',

        # Этажность
        'objects:unfinished:destination:mss_objects_app:link_param:house_flats:delete',

        # знаковый объект
        'objects:unfinished:destination:mss_objects_app:link_param:wow_obj:delete',
       
        # социально-значимый объект
        'objects:unfinished:destination:mss_objects_app:link_param:soc_zn_obj:delete',

        # объект жкх 
        'objects:unfinished:destination:mss_objects_app:link_param:obj_zkx:delete',

        # вид объекта жкх
        'objects:unfinished:destination:mss_objects_app:link_param:vid_obj_zkx:delete',
        
        # Электроэнергия
        'objects:unfinished:destination:mss_objects_app:link_param:blag_energ:delete',
        
        # Вода
        'objects:unfinished:destination:mss_objects_app:link_param:blag_water:delete',
        
        # Газ 
        'objects:unfinished:destination:mss_objects_app:link_param:blag_gaz:delete',
        
        # Канализация
        'objects:unfinished:destination:mss_objects_app:link_param:blag_kan:delete',
        
        # Лифт
        'objects:unfinished:destination:mss_objects_app:link_param:blag_lift:delete',
        
        # Мусоропровод 
        'objects:unfinished:destination:mss_objects_app:link_param:blag_mus:delete',
        
        # Отопление
        'objects:unfinished:destination:mss_objects_app:link_param:blag_hot:delete',
        
        # Телевидение
        'objects:unfinished:destination:mss_objects_app:link_param:blag_tv:delete',
        
        # Телефонизация
        'objects:unfinished:destination:mss_objects_app:link_param:blag_tel:delete',
        
        # Вентиляция
        'objects:unfinished:destination:mss_objects_app:link_param:blag_vent:delete',
        
        # Памятник 
        'objects:unfinished:destination:mss_objects_app:link_param:is_monument:delete',
        
        # Категория историко-культурного значения
        'objects:unfinished:destination:mss_objects_app:link_param:culturial_sense:delete',

        # Наименование памятника
        'objects:unfinished:destination:mss_objects_app:link_param:name_monument:delete',
 
        # Дополнительная информация о памятнике
        'objects:unfinished:destination:mss_objects_app:link_param:other_monument:delete',

        # Старый реестровый номер
        'objects:unfinished:destination:mss_objects_app:link_param:rn_old:delete',
        
        # Примечание 
        'objects:unfinished:destination:mss_objects_app:link_param:note_obj:delete',
        
        # Назначение 
        'objects:unfinished:destination:mss_objects_app:link_param:unmovable_used:delete',

        # Жилая площадь
        'objects:unfinished:destination:mss_objects_app:link_param:house_pl_gil:delete',

        # Кадастровый(условный) номер
        'objects:unfinished:destination:mss_objects_app:link_param:cad_num_dop:delete',
        
        # Площадь застройки
        'objects:unfinished:destination:mss_objects_app:link_param:pl_proj_st:delete',
        
        # Общая площадь помещений
        'objects:unfinished:destination:mss_objects_app:link_param:all_pl_st:delete',
        
        # Строительный номер
        'objects:unfinished:destination:mss_objects_app:link_param:kossm_buildno:delete',
        
        # Год начала строительства
        'objects:unfinished:destination:mss_objects_app:link_param:kossm_startyear:delete',
        
        # Год окончания строительства
        'objects:unfinished:destination:mss_objects_app:link_param:kossm_endyear:delete',
        
        # Стоимость по проекту
        'objects:unfinished:destination:mss_objects_app:link_param:kossm_startprice:delete',
        
        # Сумма инвестиций
        'objects:unfinished:destination:mss_objects_app:link_param:kossm_investsum:delete',
        
        # Кадастровая стоимость
        'objects:unfinished:destination:mss_objects_app:link_param:kadastr_price:delete',
        
        # Первоначальная стоимость
        'objects:unfinished:destination:mss_objects_app:link_param:price_first:delete',
        
        # Остаточная стоимость
        'objects:unfinished:destination:mss_objects_app:link_param:price_remain:delete',
        
        # Оценочная стоимость
        'objects:unfinished:destination:mss_objects_app:link_param:assessed_val:delete',
        

        # Счет учета ОС
        'objects:unfinished:destination:mss_objects_app:link_param:fixed_assets_account:delete',
        
        # Нормы амортизации
        'objects:unfinished:destination:mss_objects_app:object:mss_depre_rates:delete',
        
        # Амортизационные группы
        'objects:unfinished:destination:mss_objects_app:object:mss_depre_groups:delete',
        
        # Дата начала начисления амортизации
        'objects:unfinished:destination:mss_objects_app:object:mss_od_date_begin_depre:delete',
        
        # Амортизация до принятия к учету
        'objects:unfinished:destination:mss_objects_app:object:mss_od_depre_init_cost:delete',
        
        # Метод начисления амортизации 
        'objects:unfinished:destination:mss_objects_app:object:mss_od_depre_method:delete',
        
        # Оставшийся срок полезного использования в месяцах 
        'objects:unfinished:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:delete',
        
        # Оставшийся срок полезного использования в годах
        'objects:unfinished:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:delete',


        'objects:unfinished:destination:mss_objects:delete',
        'objects:unfinished:destination:mss_objects:drop___cad_quorter',
        'objects:unfinished:destination:mss_objects:drop___kadastrno',
        'objects:unfinished:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:unfinished:destination:mss_objects_adr:delete',
        'objects:unfinished:source:ids:drop___link_adr',
        'objects:unfinished:destination:mss_adr:delete',
        
        'objects:unfinished:source:ids:drop___add_hist',
        'objects:unfinished:source:ids:drop___adr_str',
        
        'objects:unfinished:destination:mss_objects:drop___house_wall_type',
        'objects:unfinished:destination:mss_objects:drop___link_house_wall_type',
        'objects:unfinished:destination:mss_objects:drop___is_immovable',
        'objects:unfinished:destination:mss_objects:drop___link_is_immovable',
        'objects:unfinished:destination:mss_objects:drop___wow_obj',
        'objects:unfinished:destination:mss_objects:drop___link_wow_obj',
        'objects:unfinished:destination:mss_objects:drop___soc_zn_obj',
        'objects:unfinished:destination:mss_objects:drop___link_soc_zn_obj',
        'objects:unfinished:destination:mss_objects:drop___obj_zkx',
        'objects:unfinished:destination:mss_objects:drop___link_obj_zkx',
        'objects:unfinished:destination:mss_objects:drop___vid_obj_zkx',
        'objects:unfinished:destination:mss_objects:drop___link_vid_obj_zkx',
        'objects:unfinished:destination:mss_objects:drop___culturial_sense',
        'objects:unfinished:destination:mss_objects:drop___link_culturial_sense',
        'objects:unfinished:destination:mss_objects:drop___unmovable_used',
        'objects:unfinished:destination:mss_objects:drop___link_unmovable_used',
      ]
    end
  end
end
