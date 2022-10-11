namespace :objects do
  namespace :movable_other do
    namespace :import do

      task :tasks do 
        Rake.invoke_task 'objects:movable_other:source:ids:insert'
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:add___dict_name' 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:add___group' 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:add___section' 

        Rake.invoke_task 'objects:movable_other:destination:mss_objects:insert'
        Rake.invoke_task 'objects:movable_other:source:ids:update_link'

        # Адрес последнего местоположения
        Rake.invoke_task 'objects:movable_other:source:ids:add___last_loc_addr'
        Rake.invoke_task 'objects:movable_other:source:ids:update___last_loc_addr'
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:link_param:last_loc_addr:insert'
        Rake.invoke_task 'objects:movable_other:source:ids:drop___last_loc_addr'
        
        # История наименования
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:link_param:obj_name_hist:insert'
        
        # ID объекта из Сауми
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:link_param:id_obj:insert'
        
        # Старый реестровый номер
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:link_param:rn_old:insert'
        
        # Примечание 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:link_param:note_obj:insert'
        
        # Значение из справочника наименований
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:add___link_dict_name' 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:update___link_dict_name' 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:link_param:dict_name:insert'
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:drop___dict_name' 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:drop___link_dict_name' 
        
        # Группы
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:add___link_group' 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:update___link_group' 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:link_param:group:insert'
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:drop___group' 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:drop___link_group' 
        
        # Разделы
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:add___link_section' 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:update___link_section' 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:link_param:section:insert'
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:drop___section' 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects:drop___link_section' 
        
        # Первоначальная стоимость
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:link_param:price_first:insert'
        
        # Остаточная стоимость
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:link_param:price_remain:insert'


        # Счет учета ОС
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:link_param:fixed_assets_account:insert'
        
        # Нормы амортизации
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:object:mss_depre_rates:insert'

        # Амортизационные группы
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:object:mss_depre_groups:insert'
        
        # Дата начала начисления амортизации
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:object:mss_od_date_begin_depre:insert'
        
        # Амортизация до принятия к учету
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:object:mss_od_depre_init_cost:insert'
        
        # Метод начисления амортизации 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:object:mss_od_depre_method:insert'
        
        # Оставшийся срок полезного использования в месяцах 
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:insert'
        
        # Оставшийся срок полезного использования в годах
        Rake.invoke_task 'objects:movable_other:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:insert'
      end 

    end
  end
end
