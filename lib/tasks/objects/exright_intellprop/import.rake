namespace :objects do
  namespace :exright_intellprop do
    namespace :import do

      task :tasks do 
        Rake.invoke_task 'objects:exright_intellprop:source:___ids:insert'
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:add___intellprop_sp' 
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:add___func_nazn_ei' 
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:add___storage_authority_ei' 

        Rake.invoke_task 'objects:exright_intellprop:source:___ids:add___link_adr'
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:insert'
        Rake.invoke_task 'objects:exright_intellprop:source:___ids:update_link'
        Rake.invoke_task 'objects:exright_intellprop:source:___ids:update___link_adr'
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_adr:insert'
        Rake.invoke_task 'objects:exright_intellprop:source:___ids:drop___link_adr'

        # История наименования
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:link_param:obj_name_hist:insert'
        
        # История инвентарного номера
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:link_param:obj_invnum_hist:insert'
        
        # ID объекта из Сауми
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:link_param:id_obj:insert'
        
        # Старый реестровый номер
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:link_param:rn_old:insert'
        
        # Примечание 
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:link_param:note_obj:insert'
        
        # Вид объекта интеллектуальной собственности
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:add___link_intellprop_sp' 
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:update___link_intellprop_sp' 
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:link_param:intellprop_sp:insert'
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:drop___intellprop_sp' 
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:drop___link_intellprop_sp' 
        
        # Функциональное назначение
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:add___link_func_nazn_ei' 
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:update___link_func_nazn_ei' 
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:link_param:func_nazn_ei:insert'
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:drop___func_nazn_ei' 
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:drop___link_func_nazn_ei' 
        
        # Орган, осуществлюящий хранение
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:add___link_storage_authority_ei' 
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:update___link_storage_authority_ei' 
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:link_param:storage_authority_ei:insert'
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:drop___storage_authority_ei' 
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:drop___link_storage_authority_ei' 
        
        # Первоначальная стоимость
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:link_param:price_first:insert'

        # Остаточная стоимость
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:link_param:price_remain:insert'
        
        # Процент износа
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:link_param:iznos:insert'

        # Состояние
        Rake.invoke_task 'objects:exright_intellprop:source:states:add___link_state' 
        Rake.invoke_task 'objects:exright_intellprop:source:states:update___link_state' 
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:link_param:state:insert'
        Rake.invoke_task 'objects:exright_intellprop:source:states:drop___link_state' 


        # Счет учета ОС
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:link_param:fixed_assets_account:insert'
        
        # Нормы амортизации
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:object:mss_depre_rates:insert'

        # Амортизационные группы
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:object:mss_depre_groups:insert'
        
        # Дата начала начисления амортизации
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:object:mss_od_date_begin_depre:insert'
        
        # Амортизация до принятия к учету
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:object:mss_od_depre_init_cost:insert'
        
        # Метод начисления амортизации 
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:object:mss_od_depre_method:insert'
        
        # Оставшийся срок полезного использования в месяцах 
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:insert'
        
        # Оставшийся срок полезного использования в годах
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:insert'
      end 

    end
  end
end
