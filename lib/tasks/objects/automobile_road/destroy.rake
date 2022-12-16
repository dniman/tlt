namespace :objects do
  namespace :automobile_road do
    namespace :destroy do

      task :tasks => [
        'objects:automobile_road:destination:___del_ids:insert',

        # История адреса
        'objects:automobile_road:destination:mss_objects_app:link_param:add_hist:delete',
        
        # История наименования
        'objects:automobile_road:destination:mss_objects_app:link_param:obj_name_hist:delete',

        # Официальный адрес 
        'objects:automobile_road:destination:mss_objects_app:link_param:adr_str:delete',

        # Общая площадь
        'objects:automobile_road:destination:mss_objects_app:link_param:house_pl:delete',

        # ID объекта из Сауми
        'objects:automobile_road:destination:mss_objects_app:link_param:id_obj:delete',
        
        # Код ОКОФ
        'objects:automobile_road:destination:mss_objects_app:link_param:okof:delete',
        
        # Инвентарный номер
        'objects:automobile_road:destination:mss_objects_app:link_param:hous_inv_n:delete',
        
        # Год ввода в эксплуатацию 
        'objects:automobile_road:destination:mss_objects_app:link_param:year_vvod:delete',
        
        # Дата ввода в эксплуатацию 
        'objects:automobile_road:destination:mss_objects_app:link_param:house_date_begin_use:delete',
       
        # Материал
        'objects:automobile_road:destination:mss_objects_app:link_param:house_material:delete',
        
        # Литера БТИ
        'objects:automobile_road:destination:mss_objects_app:link_param:bti_liter:delete',
        
        # Объем
        'objects:automobile_road:destination:mss_objects_app:link_param:capacity:delete',
        
        # Является недвижимым имуществом
        'objects:automobile_road:destination:mss_objects_app:link_param:is_immovable:delete',
        
        # Этажность
        'objects:automobile_road:destination:mss_objects_app:link_param:house_flats:delete',
       
        # знаковый объект
        'objects:automobile_road:destination:mss_objects_app:link_param:wow_obj:delete',
       
        # социально-значимый объект
        'objects:automobile_road:destination:mss_objects_app:link_param:soc_zn_obj:delete',

        # объект жкх 
        'objects:automobile_road:destination:mss_objects_app:link_param:obj_zkx:delete',

        # вид объекта жкх
        'objects:automobile_road:destination:mss_objects_app:link_param:vid_obj_zkx:delete',

        # Электроэнергия
        'objects:automobile_road:destination:mss_objects_app:link_param:blag_energ:delete',
        
        # Вода
        'objects:automobile_road:destination:mss_objects_app:link_param:blag_water:delete',
        
        # Газ 
        'objects:automobile_road:destination:mss_objects_app:link_param:blag_gaz:delete',
        
        # Канализация
        'objects:automobile_road:destination:mss_objects_app:link_param:blag_kan:delete',
        
        # Лифт
        'objects:automobile_road:destination:mss_objects_app:link_param:blag_lift:delete',
        
        # Мусоропровод 
        'objects:automobile_road:destination:mss_objects_app:link_param:blag_mus:delete',
        
        # Отопление
        'objects:automobile_road:destination:mss_objects_app:link_param:blag_hot:delete',
        
        # Телевидение
        'objects:automobile_road:destination:mss_objects_app:link_param:blag_tv:delete',
        
        # Телефонизация
        'objects:automobile_road:destination:mss_objects_app:link_param:blag_tel:delete',
        
        # Вентиляция
        'objects:automobile_road:destination:mss_objects_app:link_param:blag_vent:delete',
        
        # Памятник 
        'objects:automobile_road:destination:mss_objects_app:link_param:is_monument:delete',
        
        # Категория историко-культурного значения
        'objects:automobile_road:destination:mss_objects_app:link_param:culturial_sense:delete',
        
        # Наименование памятника
        'objects:automobile_road:destination:mss_objects_app:link_param:name_monument:delete',
        
        # Дополнительная информация о памятнике
        'objects:automobile_road:destination:mss_objects_app:link_param:other_monument:delete',

        # Старый реестровый номер
        'objects:automobile_road:destination:mss_objects_app:link_param:rn_old:delete',

        # Примечание 
        'objects:automobile_road:destination:mss_objects_app:link_param:note_obj:delete',
        
        # Кадастровый(условный) номер
        'objects:automobile_road:destination:mss_objects_app:link_param:cad_num_dop:delete',
        
        # Протяженность
        'objects:automobile_road:destination:mss_objects_app:link_param:house_spread:delete',
        
        # Ширина
        'objects:automobile_road:destination:mss_objects_app:link_param:width:delete',
        
        # Глубина 
        'objects:automobile_road:destination:mss_objects_app:link_param:depth:delete',
        
        # Площадь застройки
        'objects:automobile_road:destination:mss_objects_app:link_param:built_up_area:delete',
        
        # Назначение
        'objects:automobile_road:destination:mss_objects_app:link_param:unmovable_used:delete',
        
        # Идентификационный номер автодороги
        'objects:automobile_road:destination:mss_objects_app:link_param:id_avtodor:delete',
        
        # Вид разрешенного использования автодороги
        'objects:automobile_road:destination:mss_objects_app:link_param:vri_avtodor:delete',
        
        # Класс автодороги
        'objects:automobile_road:destination:mss_objects_app:link_param:klass_avtodor:delete',
        
        # Категория автодороги
        'objects:automobile_road:destination:mss_objects_app:link_param:kateg_avtodor:delete',
        
        # Группа сооружений
        'objects:automobile_road:destination:mss_objects_app:link_param:group_im:delete',
        
        # Кадастровая стоимость
        'objects:automobile_road:destination:mss_objects_app:link_param:kadastr_price:delete',
        
        # Первоначальная стоимость
        'objects:automobile_road:destination:mss_objects_app:link_param:price_first:delete',
        
        # Остаточная стоимость
        'objects:automobile_road:destination:mss_objects_app:link_param:price_remain:delete',
        
        # Оценочная стоимость
        'objects:automobile_road:destination:mss_objects_app:link_param:assessed_val:delete',
        
        # Процент износа
        'objects:automobile_road:destination:mss_objects_app:link_param:iznos:delete',
        
        # Состояние
        'objects:automobile_road:destination:mss_objects_app:link_param:state:delete',
        

        # Счет учета ОС
        'objects:automobile_road:destination:mss_objects_app:link_param:fixed_assets_account:delete',
        
        # Нормы амортизации
        'objects:automobile_road:destination:mss_objects_app:object:mss_depre_rates:delete',
        
        # Амортизационные группы
        'objects:automobile_road:destination:mss_objects_app:object:mss_depre_groups:delete',
        
        # Дата начала начисления амортизации
        'objects:automobile_road:destination:mss_objects_app:object:mss_od_date_begin_depre:delete',
        
        # Амортизация до принятия к учету
        'objects:automobile_road:destination:mss_objects_app:object:mss_od_depre_init_cost:delete',
        
        # Метод начисления амортизации 
        'objects:automobile_road:destination:mss_objects_app:object:mss_od_depre_method:delete',
        
        # Оставшийся срок полезного использования в месяцах 
        'objects:automobile_road:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:delete',
        
        # Оставшийся срок полезного использования в годах
        'objects:automobile_road:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:delete',
        
        # Земельные участки, в пределах которого находится объект
        'objects:automobile_road:destination:mss_objects_parentland:delete',

        # Документы
        'objects:automobile_road:destination:mss_detail_list:delete',
        'objects:automobile_road:source:___ids:drop___link_list',

        'objects:automobile_road:destination:mss_objects:delete',
        'objects:automobile_road:destination:mss_objects:drop___cad_quorter',
        'objects:automobile_road:destination:mss_objects:drop___kadastrno',
        'objects:automobile_road:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:automobile_road:destination:mss_objects_adr:delete',
        'objects:automobile_road:source:___ids:drop___link_adr',
        'objects:automobile_road:destination:mss_adr:delete',
        'objects:automobile_road:source:___ids:drop___add_hist',
        'objects:automobile_road:source:___ids:drop___adr_str',
        'objects:automobile_road:destination:___del_ids:delete',
        
        'objects:automobile_road:destination:mss_objects:drop___house_material',
        'objects:automobile_road:destination:mss_objects:drop___link_house_material',
        'objects:automobile_road:destination:mss_objects:drop___is_immovable',
        'objects:automobile_road:destination:mss_objects:drop___link_is_immovable',
        'objects:automobile_road:destination:mss_objects:drop___wow_obj',
        'objects:automobile_road:destination:mss_objects:drop___link_wow_obj',
        'objects:automobile_road:destination:mss_objects:drop___soc_zn_obj',
        'objects:automobile_road:destination:mss_objects:drop___link_soc_zn_obj',
        'objects:automobile_road:destination:mss_objects:drop___obj_zkx',
        'objects:automobile_road:destination:mss_objects:drop___link_obj_zkx',
        'objects:automobile_road:destination:mss_objects:drop___vid_obj_zkx',
        'objects:automobile_road:destination:mss_objects:drop___link_vid_obj_zkx',
        'objects:automobile_road:destination:mss_objects:drop___culturial_sense',
        'objects:automobile_road:destination:mss_objects:drop___link_culturial_sense',
        'objects:automobile_road:destination:mss_objects:drop___unmovable_used',
        'objects:automobile_road:destination:mss_objects:drop___link_unmovable_used',
        'objects:automobile_road:destination:mss_objects:drop___vri_avtodor',
        'objects:automobile_road:destination:mss_objects:drop___link_vri_avtodor',
        'objects:automobile_road:destination:mss_objects:drop___klass_avtodor',
        'objects:automobile_road:destination:mss_objects:drop___link_klass_avtodor',
        'objects:automobile_road:destination:mss_objects:drop___kateg_avtodor',
        'objects:automobile_road:destination:mss_objects:drop___link_kateg_avtodor',
        'objects:automobile_road:destination:mss_objects:drop___group_im',
        'objects:automobile_road:destination:mss_objects:drop___link_group_im',
        'objects:automobile_road:source:states:drop___link_state',
      ]

    end
  end
end
