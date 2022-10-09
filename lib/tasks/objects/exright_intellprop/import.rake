namespace :objects do
  namespace :exright_intellprop do
    namespace :import do

      task :tasks do 
        Rake.invoke_task 'objects:exright_intellprop:source:ids:insert'
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:add___intellprop_sp' 
        #Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:add___group' 
        #Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:add___section' 

        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:insert'
        Rake.invoke_task 'objects:exright_intellprop:source:ids:update_link'

        # История наименования
        Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:link_param:obj_name_hist:insert'
        
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
        
        # Группы
        #Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:add___link_group' 
        #Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:update___link_group' 
        #Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:link_param:group:insert'
        #Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:drop___group' 
        #Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:drop___link_group' 
        
        # Разделы
        #Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:add___link_section' 
        #Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:update___link_section' 
        #Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects_app:link_param:section:insert'
        #Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:drop___section' 
        #Rake.invoke_task 'objects:exright_intellprop:destination:mss_objects:drop___link_section' 
        

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
