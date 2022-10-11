namespace :objects do
  namespace :share do
    namespace :import do

      task :tasks do 
        Rake.invoke_task 'objects:share:source:ids:insert'

        Rake.invoke_task 'objects:share:destination:mss_objects:insert'
        Rake.invoke_task 'objects:share:source:ids:update_link'
        Rake.invoke_task 'objects:share:destination:t_corr_dict:reference_corr_type:emmitstock:insert'

        # История наименования
        Rake.invoke_task 'objects:share:destination:mss_objects_app:link_param:obj_name_hist:insert'
        
        # ID объекта из Сауми
        Rake.invoke_task 'objects:share:destination:mss_objects_app:link_param:id_obj:insert'
        
        # Старый реестровый номер
        Rake.invoke_task 'objects:share:destination:mss_objects_app:link_param:rn_old:insert'
        
        # Примечание 
        Rake.invoke_task 'objects:share:destination:mss_objects_app:link_param:note_obj:insert'
        
        # Первоначальная стоимость
        Rake.invoke_task 'objects:share:destination:mss_objects_app:link_param:price_first:insert'

        
        # Счет учета ОС
        Rake.invoke_task 'objects:share:destination:mss_objects_app:link_param:fixed_assets_account:insert'
        
        # Нормы амортизации
        Rake.invoke_task 'objects:share:destination:mss_objects_app:object:mss_depre_rates:insert'

        # Амортизационные группы
        Rake.invoke_task 'objects:share:destination:mss_objects_app:object:mss_depre_groups:insert'
        
        # Дата начала начисления амортизации
        Rake.invoke_task 'objects:share:destination:mss_objects_app:object:mss_od_date_begin_depre:insert'
        
        # Амортизация до принятия к учету
        Rake.invoke_task 'objects:share:destination:mss_objects_app:object:mss_od_depre_init_cost:insert'
        
        # Метод начисления амортизации 
        Rake.invoke_task 'objects:share:destination:mss_objects_app:object:mss_od_depre_method:insert'
        
        # Оставшийся срок полезного использования в месяцах 
        Rake.invoke_task 'objects:share:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:insert'
        
        # Оставшийся срок полезного использования в годах
        Rake.invoke_task 'objects:share:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:insert'
      end 

    end
  end
end
