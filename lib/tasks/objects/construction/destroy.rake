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
        'objects:construction:destination:mss_objects_app:wow_obj:delete',
       
        # социально-значимый объект
        'objects:construction:destination:mss_objects_app:soc_zn_obj:delete',

        # объект жкх 
        'objects:construction:destination:mss_objects_app:obj_zkx:delete',

        # вид объекта жкх
        'objects:construction:destination:mss_objects_app:vid_obj_zkx:delete',

        # Электроэнергия
        'objects:construction:destination:mss_objects_app:blag_energ:delete',
        
        # Вода
        'objects:construction:destination:mss_objects_app:blag_water:delete',
        
        # Газ 
        'objects:construction:destination:mss_objects_app:blag_gaz:delete',
        
        # Канализация
        'objects:construction:destination:mss_objects_app:blag_kan:delete',
        
        # Лифт
        'objects:construction:destination:mss_objects_app:blag_lift:delete',
        
        # Мусоропровод 
        'objects:construction:destination:mss_objects_app:blag_mus:delete',
        
        # Отопление
        'objects:construction:destination:mss_objects_app:blag_hot:delete',
        
        # Телевидение
        'objects:construction:destination:mss_objects_app:blag_tv:delete',
        
        # Телефонизация
        'objects:construction:destination:mss_objects_app:blag_tel:delete',
        
        # Вентиляция
        'objects:construction:destination:mss_objects_app:blag_vent:delete',
        
        # Памятник 
        'objects:construction:destination:mss_objects_app:is_monument:delete',
        
        # Категория историко-культурного значения
        'objects:construction:destination:mss_objects_app:culturial_sense:delete',
        
        # Наименование памятника
        'objects:construction:destination:mss_objects_app:name_monument:delete',
        
        # Дополнительная информация о памятнике
        'objects:construction:destination:mss_objects_app:other_monument:delete',

        # Старый реестровый номер
        'objects:construction:destination:mss_objects_app:rn_old:delete',

        # Примечание 
        'objects:construction:destination:mss_objects_app:note_obj:delete',
        
        # Кадастровый(условный) номер
        'objects:construction:destination:mss_objects_app:cad_num_dop:delete',
        
        # Протяженность
        'objects:construction:destination:mss_objects_app:house_spread:delete',
        
        # Ширина
        'objects:construction:destination:mss_objects_app:width:delete',
        
        # Глубина 
        'objects:construction:destination:mss_objects_app:depth:delete',
        
        # Площадь застройки
        'objects:construction:destination:mss_objects_app:built_up_area:delete',
        
        # Материал
        'objects:construction:destination:mss_objects_app:unmovable_used:delete',
        
        # Идентификационный номер автодороги
        'objects:construction:destination:mss_objects_app:id_avtodor:delete',
        
        # Вид разрешенного использования автодороги
        'objects:construction:destination:mss_objects_app:vri_avtodor:delete',
        
        # Класс автодороги
        'objects:construction:destination:mss_objects_app:klass_avtodor:delete',
        
        # Категория автодороги
        'objects:construction:destination:mss_objects_app:kateg_avtodor:delete',
        
        # Группа сооружений
        'objects:construction:destination:mss_objects_app:group_im:delete',

        'objects:construction:destination:mss_objects:delete',
        'objects:construction:destination:mss_objects:drop___cad_quorter',
        'objects:construction:destination:mss_objects:drop___kadastrno',
        'objects:construction:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:construction:destination:mss_objects_adr:delete',
        'objects:construction:source:ids:drop___link_adr',
        'objects:construction:destination:mss_adr:delete',
        'objects:construction:source:ids:drop___add_hist',
        'objects:construction:source:ids:drop___adr_str',
        
        'objects:construction:destination:mss_objects:drop___house_material',
        'objects:construction:destination:mss_objects:drop___link_house_material',
        'objects:construction:destination:mss_objects:drop___is_immovable',
        'objects:construction:destination:mss_objects:drop___link_is_immovable',
        'objects:construction:destination:mss_objects:drop___wow_obj',
        'objects:construction:destination:mss_objects:drop___link_wow_obj',
        'objects:construction:destination:mss_objects:drop___soc_zn_obj',
        'objects:construction:destination:mss_objects:drop___link_soc_zn_obj',
        'objects:construction:destination:mss_objects:drop___obj_zkx',
        'objects:construction:destination:mss_objects:drop___link_obj_zkx',
        'objects:construction:destination:mss_objects:drop___vid_obj_zkx',
        'objects:construction:destination:mss_objects:drop___link_vid_obj_zkx',
        'objects:construction:destination:mss_objects:drop___culturial_sense',
        'objects:construction:destination:mss_objects:drop___link_culturial_sense',
        'objects:construction:destination:mss_objects:drop___unmovable_used',
        'objects:construction:destination:mss_objects:drop___link_unmovable_used',
        'objects:construction:destination:mss_objects:drop___vri_avtodor',
        'objects:construction:destination:mss_objects:drop___link_vri_avtodor',
        'objects:construction:destination:mss_objects:drop___klass_avtodor',
        'objects:construction:destination:mss_objects:drop___link_klass_avtodor',
        'objects:construction:destination:mss_objects:drop___kateg_avtodor',
        'objects:construction:destination:mss_objects:drop___link_kateg_avtodor',
        'objects:construction:destination:mss_objects:drop___group_im',
        'objects:construction:destination:mss_objects:drop___link_group_im',
      ]

    end
  end
end
