namespace :objects do
  namespace :houses_unlife do
    namespace :import do

      task :tasks do 
        Rake.invoke_task 'objects:houses_unlife:source:ids:insert'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___house_wall_type' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___is_immovable'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___wow_obj' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___soc_zn_obj' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___obj_zkx' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___vid_obj_zkx' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___culturial_sense' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___unmovable_used' 

        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___kadastrno'
        Rake.invoke_task 'objects:houses_unlife:source:ids:add___link_adr'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:insert'
        Rake.invoke_task 'objects:houses_unlife:source:ids:update_link'
        Rake.invoke_task 'objects:houses_unlife:source:ids:update___link_adr'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:update_inventar_num'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___cad_quorter' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:update___cad_quorter'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_dicts:object:dictionary_land_kvartals:insert'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:update_link_cad_quorter'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___cad_quorter'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___kadastrno'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_adr:insert'
        Rake.invoke_task 'objects:houses_unlife:source:ids:drop___link_adr'

        # История адреса
        Rake.invoke_task 'objects:houses_unlife:source:ids:add___add_hist'
        Rake.invoke_task 'objects:houses_unlife:source:ids:update___add_hist'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:add_hist:insert'
        Rake.invoke_task 'objects:houses_unlife:source:ids:drop___add_hist'
        
        # История наименования
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:obj_name_hist:insert'
        
        # Официальный адрес
        Rake.invoke_task 'objects:houses_unlife:source:ids:add___adr_str'
        Rake.invoke_task 'objects:houses_unlife:source:ids:update___adr_str'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:adr_str:insert'
        Rake.invoke_task 'objects:houses_unlife:source:ids:drop___adr_str'
        
        # Общая площадь
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:house_pl:insert'

        # ID объекта из Сауми
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:id_obj:insert'
        
        # Код ОКОФ
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:okof:insert'
        
        # Инвентарный номер 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:hous_inv_n:insert'
        
        # Год ввода в эксплуатацию 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:year_vvod:insert'
        
        # Дата ввода в эксплуатацию 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:house_date_begin_use:insert'

        # Материал стен
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___link_house_wall_type' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:update___link_house_wall_type' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:house_wall_type:insert'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___house_wall_type' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___link_house_wall_type' 
        
        # Литера БТИ 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:bti_liter:insert'
        
        # Является недвижимым имуществом
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___link_is_immovable' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:update___link_is_immovable' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:is_immovable:insert'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___is_immovable' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___link_is_immovable' 
        
        # Этажность
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:house_flats:insert'
        
        # знаковый объект
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___link_wow_obj' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:update___link_wow_obj' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:wow_obj:insert'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___wow_obj' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___link_wow_obj' 
        
        # социально-значимый объект
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___link_soc_zn_obj' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:update___link_soc_zn_obj' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:soc_zn_obj:insert'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___soc_zn_obj' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___link_soc_zn_obj' 
        
        # объект жкх 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___link_obj_zkx' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:update___link_obj_zkx' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:obj_zkx:insert'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___obj_zkx' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___link_obj_zkx' 
       
        # вид объекта жкх
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___link_vid_obj_zkx' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:update___link_vid_obj_zkx' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:vid_obj_zkx:insert'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___vid_obj_zkx' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___link_vid_obj_zkx' 
        
        # Электроэнергия 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:blag_energ:insert'
        
        # Вода
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:blag_water:insert'

        # Газ 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:blag_gaz:insert'
        
        # Канализация 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:blag_kan:insert'
        
        # Лифт
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:blag_lift:insert'
        
        # Мусоропровод 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:blag_mus:insert'
        
        # Отопление 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:blag_hot:insert'
        
        # Телевидение 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:blag_tv:insert'
        
        # Телефонизация
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:blag_tel:insert'
        
        # Вентиляция
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:blag_vent:insert'
        
        # Памятник
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:is_monument:insert'
        
        # Категория историко-культурного значения 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___link_culturial_sense' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:update___link_culturial_sense' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:culturial_sense:insert'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___culturial_sense' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___link_culturial_sense' 
        
        # Наименование памятника
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:name_monument:insert'
        
        # Дополнительная информация о памятнике
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:other_monument:insert'
        
        # Старый реестровый номер
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:rn_old:insert'
        
        # Примечание 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:note_obj:insert'
        
        # Назначение
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:add___link_unmovable_used' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:update___link_unmovable_used' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:unmovable_used:insert'
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___unmovable_used' 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects:drop___link_unmovable_used' 
        
        # Жилая площадь
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:house_pl_gil:insert'
        

        # Счет учета ОС
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:link_param:fixed_assets_account:insert'
        
        # Нормы амортизации
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:object:mss_depre_rates:insert'

        # Амортизационные группы
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:object:mss_depre_groups:insert'
        
        # Дата начала начисления амортизации
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:object:mss_od_date_begin_depre:insert'
        
        # Амортизация до принятия к учету
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:object:mss_od_depre_init_cost:insert'
        
        # Метод начисления амортизации 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:object:mss_od_depre_method:insert'
        
        # Оставшийся срок полезного использования в месяцах 
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:insert'
        
        # Оставшийся срок полезного использования в годах
        Rake.invoke_task 'objects:houses_unlife:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:insert'
      end 

    end
  end
end
