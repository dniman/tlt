namespace :objects do
  namespace :partnership do
    namespace :import do

      task :tasks do 
        Rake.invoke_task 'objects:partnership:source:___ids:insert', 'UNDELETABLE'

        Rake.invoke_task 'objects:partnership:destination:mss_objects:insert'
        Rake.invoke_task 'objects:partnership:source:___ids:update_link'
        Rake.invoke_task 'objects:partnership:destination:t_corr_dict:reference_corr_type:partnership:insert'

        # История наименования
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:obj_name_hist:insert'
        
        # ID объекта из Сауми
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:id_obj:insert'
        
        # Старый реестровый номер
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:rn_old:insert'
        
        # Примечание 
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:note_obj:insert'
        
        # Первоначальная стоимость
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:price_first:insert'
        
        # Остаточная стоимость
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:price_remain:insert'
        
        # Доля в уставном капитале
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:capital_share:insert'
        
        # Доля,руб
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:share_rub:insert'
        
        # Состояние
        Rake.invoke_task 'objects:partnership:source:states:add___link_state' 
        Rake.invoke_task 'objects:partnership:source:states:update___link_state' 
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:state:insert'
        Rake.invoke_task 'objects:partnership:source:states:drop___link_state' 

        # Счет учета ОС
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:link_param:fixed_assets_account:insert'
        
        # Нормы амортизации
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:object:mss_depre_rates:insert'

        # Амортизационные группы
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:object:mss_depre_groups:insert'
        
        # Дата начала начисления амортизации
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:object:mss_od_date_begin_depre:insert'
        
        # Амортизация до принятия к учету
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:object:mss_od_depre_init_cost:insert'
        
        # Метод начисления амортизации 
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:object:mss_od_depre_method:insert'
        
        # Оставшийся срок полезного использования в месяцах 
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:insert'
        
        # Оставшийся срок полезного использования в годах
        Rake.invoke_task 'objects:partnership:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:insert'
        
        # Привязка документов
        Rake.invoke_task 'objects:partnership:source:___ids:add___link_list'
        Rake.invoke_task 'objects:partnership:source:___ids:update___link_list'
        Rake.invoke_task 'objects:partnership:destination:mss_detail_list:insert'
        Rake.invoke_task 'objects:partnership:source:___ids:drop___link_list'
      end 

    end
  end
end
