namespace :objects do
  namespace :engineering_network do
    namespace :destroy do

      task :tasks => [
        'objects:engineering_network:destination:___del_ids:insert',

        # История адреса
        'objects:engineering_network:destination:mss_objects_app:link_param:add_hist:delete',
        
        # История наименования
        'objects:engineering_network:destination:mss_objects_app:link_param:obj_name_hist:delete',

        # Официальный адрес 
        'objects:engineering_network:destination:mss_objects_app:link_param:adr_str:delete',

        # Общая площадь
        'objects:engineering_network:destination:mss_objects_app:link_param:house_pl:delete',

        # ID объекта из Сауми
        'objects:engineering_network:destination:mss_objects_app:link_param:id_obj:delete',
        
        # Код ОКОФ
        'objects:engineering_network:destination:mss_objects_app:link_param:okof:delete',
        
        # Инвентарный номер
        'objects:engineering_network:destination:mss_objects_app:link_param:hous_inv_n:delete',
        
        # Год ввода в эксплуатацию 
        'objects:engineering_network:destination:mss_objects_app:link_param:year_vvod:delete',
        
        # Дата ввода в эксплуатацию 
        'objects:engineering_network:destination:mss_objects_app:link_param:house_date_begin_use:delete',
       
        # Материал
        'objects:engineering_network:destination:mss_objects_app:link_param:house_material:delete',
        
        # Литера БТИ
        'objects:engineering_network:destination:mss_objects_app:link_param:bti_liter:delete',
        
        # Объем
        'objects:engineering_network:destination:mss_objects_app:link_param:capacity:delete',
        
        # Является недвижимым имуществом
        'objects:engineering_network:destination:mss_objects_app:link_param:is_immovable:delete',
        
        # Этажность
        'objects:engineering_network:destination:mss_objects_app:link_param:house_flats:delete',
       
        # знаковый объект
        'objects:engineering_network:destination:mss_objects_app:link_param:wow_obj:delete',
       
        # социально-значимый объект
        'objects:engineering_network:destination:mss_objects_app:link_param:soc_zn_obj:delete',

        # объект жкх 
        'objects:engineering_network:destination:mss_objects_app:link_param:obj_zkx:delete',

        # вид объекта жкх
        'objects:engineering_network:destination:mss_objects_app:link_param:vid_obj_zkx:delete',

        # Электроэнергия
        'objects:engineering_network:destination:mss_objects_app:link_param:blag_energ:delete',
        
        # Вода
        'objects:engineering_network:destination:mss_objects_app:link_param:blag_water:delete',
        
        # Газ 
        'objects:engineering_network:destination:mss_objects_app:link_param:blag_gaz:delete',
        
        # Канализация
        'objects:engineering_network:destination:mss_objects_app:link_param:blag_kan:delete',
        
        # Лифт
        'objects:engineering_network:destination:mss_objects_app:link_param:blag_lift:delete',
        
        # Мусоропровод 
        'objects:engineering_network:destination:mss_objects_app:link_param:blag_mus:delete',
        
        # Отопление
        'objects:engineering_network:destination:mss_objects_app:link_param:blag_hot:delete',
        
        # Телевидение
        'objects:engineering_network:destination:mss_objects_app:link_param:blag_tv:delete',
        
        # Телефонизация
        'objects:engineering_network:destination:mss_objects_app:link_param:blag_tel:delete',
        
        # Вентиляция
        'objects:engineering_network:destination:mss_objects_app:link_param:blag_vent:delete',
        
        # Памятник 
        'objects:engineering_network:destination:mss_objects_app:link_param:is_monument:delete',
        
        # Категория историко-культурного значения
        'objects:engineering_network:destination:mss_objects_app:link_param:culturial_sense:delete',
        
        # Наименование памятника
        'objects:engineering_network:destination:mss_objects_app:link_param:name_monument:delete',
        
        # Дополнительная информация о памятнике
        'objects:engineering_network:destination:mss_objects_app:link_param:other_monument:delete',

        # Старый реестровый номер
        'objects:engineering_network:destination:mss_objects_app:link_param:rn_old:delete',

        # Примечание 
        'objects:engineering_network:destination:mss_objects_app:link_param:note_obj:delete',
        
        # Кадастровый(условный) номер
        'objects:engineering_network:destination:mss_objects_app:link_param:cad_num_dop:delete',
        
        # Протяженность
        'objects:engineering_network:destination:mss_objects_app:link_param:house_spread:delete',
        
        # Ширина
        'objects:engineering_network:destination:mss_objects_app:link_param:width:delete',
        
        # Глубина 
        'objects:engineering_network:destination:mss_objects_app:link_param:depth:delete',
        
        # Площадь застройки
        'objects:engineering_network:destination:mss_objects_app:link_param:built_up_area:delete',
        
        # Назначение
        'objects:engineering_network:destination:mss_objects_app:link_param:unmovable_used:delete',
        
        # Идентификационный номер автодороги
        'objects:engineering_network:destination:mss_objects_app:link_param:id_avtodor:delete',
        
        # Вид разрешенного использования автодороги
        'objects:engineering_network:destination:mss_objects_app:link_param:vri_avtodor:delete',
        
        # Класс автодороги
        'objects:engineering_network:destination:mss_objects_app:link_param:klass_avtodor:delete',
        
        # Категория автодороги
        'objects:engineering_network:destination:mss_objects_app:link_param:kateg_avtodor:delete',
        
        # Группа сооружений
        'objects:engineering_network:destination:mss_objects_app:link_param:group_im:delete',
        
        # Кадастровая стоимость
        'objects:engineering_network:destination:mss_objects_app:link_param:kadastr_price:delete',
        
        # Первоначальная стоимость
        'objects:engineering_network:destination:mss_objects_app:link_param:price_first:delete',
        
        # Остаточная стоимость
        'objects:engineering_network:destination:mss_objects_app:link_param:price_remain:delete',
        
        # Оценочная стоимость
        'objects:engineering_network:destination:mss_objects_app:link_param:assessed_val:delete',
        
        # Процент износа
        'objects:engineering_network:destination:mss_objects_app:link_param:iznos:delete',
        
        # Состояние
        'objects:engineering_network:destination:mss_objects_app:link_param:state:delete',
        

        # Счет учета ОС
        'objects:engineering_network:destination:mss_objects_app:link_param:fixed_assets_account:delete',
        
        # Нормы амортизации
        'objects:engineering_network:destination:mss_objects_app:object:mss_depre_rates:delete',
        
        # Амортизационные группы
        'objects:engineering_network:destination:mss_objects_app:object:mss_depre_groups:delete',
        
        # Дата начала начисления амортизации
        'objects:engineering_network:destination:mss_objects_app:object:mss_od_date_begin_depre:delete',
        
        # Амортизация до принятия к учету
        'objects:engineering_network:destination:mss_objects_app:object:mss_od_depre_init_cost:delete',
        
        # Метод начисления амортизации 
        'objects:engineering_network:destination:mss_objects_app:object:mss_od_depre_method:delete',
        
        # Оставшийся срок полезного использования в месяцах 
        'objects:engineering_network:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:delete',
        
        # Оставшийся срок полезного использования в годах
        'objects:engineering_network:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:delete',
        
        # Земельные участки, в пределах которого находится объект
        'objects:engineering_network:destination:mss_objects_parentland:delete',

        # Документы
        'objects:engineering_network:destination:mss_detail_list:delete',
        'objects:engineering_network:source:___ids:drop___link_list',

        'objects:engineering_network:destination:mss_objects:delete',
        'objects:engineering_network:destination:mss_objects:drop___cad_quorter',
        'objects:engineering_network:destination:mss_objects:drop___kadastrno',
        'objects:engineering_network:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:engineering_network:destination:mss_objects_adr:delete',
        'objects:engineering_network:destination:mss_adr:delete',
        'objects:engineering_network:destination:___del_ids:delete',
        
        'objects:engineering_network:source:___ids:drop___link_adr',
        'objects:engineering_network:source:___ids:drop___add_hist',
        'objects:engineering_network:source:___ids:drop___adr_str',
        'objects:engineering_network:destination:mss_objects:drop___house_material',
        'objects:engineering_network:destination:mss_objects:drop___link_house_material',
        'objects:engineering_network:destination:mss_objects:drop___is_immovable',
        'objects:engineering_network:destination:mss_objects:drop___link_is_immovable',
        'objects:engineering_network:destination:mss_objects:drop___wow_obj',
        'objects:engineering_network:destination:mss_objects:drop___link_wow_obj',
        'objects:engineering_network:destination:mss_objects:drop___soc_zn_obj',
        'objects:engineering_network:destination:mss_objects:drop___link_soc_zn_obj',
        'objects:engineering_network:destination:mss_objects:drop___obj_zkx',
        'objects:engineering_network:destination:mss_objects:drop___link_obj_zkx',
        'objects:engineering_network:destination:mss_objects:drop___vid_obj_zkx',
        'objects:engineering_network:destination:mss_objects:drop___link_vid_obj_zkx',
        'objects:engineering_network:destination:mss_objects:drop___culturial_sense',
        'objects:engineering_network:destination:mss_objects:drop___link_culturial_sense',
        'objects:engineering_network:destination:mss_objects:drop___unmovable_used',
        'objects:engineering_network:destination:mss_objects:drop___link_unmovable_used',
        'objects:engineering_network:destination:mss_objects:drop___vri_avtodor',
        'objects:engineering_network:destination:mss_objects:drop___link_vri_avtodor',
        'objects:engineering_network:destination:mss_objects:drop___klass_avtodor',
        'objects:engineering_network:destination:mss_objects:drop___link_klass_avtodor',
        'objects:engineering_network:destination:mss_objects:drop___kateg_avtodor',
        'objects:engineering_network:destination:mss_objects:drop___link_kateg_avtodor',
        'objects:engineering_network:destination:mss_objects:drop___group_im',
        'objects:engineering_network:destination:mss_objects:drop___link_group_im',
        'objects:engineering_network:source:states:drop___link_state',
      ]

    end
  end
end
