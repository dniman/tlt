namespace :objects do
  namespace :exright_intellprop do
    namespace :destroy do
      task :tasks => [
        
        # История наименования
        'objects:exright_intellprop:destination:mss_objects_app:link_param:obj_name_hist:delete',
        
        # История инвентарного номера
        'objects:exright_intellprop:destination:mss_objects_app:link_param:obj_invnum_hist:delete',

        # ID объекта из Сауми
        'objects:exright_intellprop:destination:mss_objects_app:link_param:id_obj:delete',
        
        # Старый реестровый номер
        'objects:exright_intellprop:destination:mss_objects_app:link_param:rn_old:delete',
        
        # Примечание 
        'objects:exright_intellprop:destination:mss_objects_app:link_param:note_obj:delete',
        
        # Вид объекта интеллектуальной собственности
        'objects:exright_intellprop:destination:mss_objects_app:link_param:intellprop_sp:delete',
        
        # Функциональное назначение
        'objects:exright_intellprop:destination:mss_objects_app:link_param:func_nazn_ei:delete',
        
        # Орган, осуществлюящий хранение
        'objects:exright_intellprop:destination:mss_objects_app:link_param:storage_authority_ei:delete',
        
        # Первоначальная стоимость
        'objects:exright_intellprop:destination:mss_objects_app:link_param:price_first:delete',
        
        # Остаточная стоимость
        'objects:exright_intellprop:destination:mss_objects_app:link_param:price_remain:delete',
        
        # Счет учета ОС
        'objects:exright_intellprop:destination:mss_objects_app:link_param:fixed_assets_account:delete',
        
        # Нормы амортизации
        'objects:exright_intellprop:destination:mss_objects_app:object:mss_depre_rates:delete',
        
        # Амортизационные группы
        'objects:exright_intellprop:destination:mss_objects_app:object:mss_depre_groups:delete',
        
        # Дата начала начисления амортизации
        'objects:exright_intellprop:destination:mss_objects_app:object:mss_od_date_begin_depre:delete',
        
        # Амортизация до принятия к учету
        'objects:exright_intellprop:destination:mss_objects_app:object:mss_od_depre_init_cost:delete',
        
        # Метод начисления амортизации 
        'objects:exright_intellprop:destination:mss_objects_app:object:mss_od_depre_method:delete',
        
        # Оставшийся срок полезного использования в месяцах 
        'objects:exright_intellprop:destination:mss_objects_app:object:mss_od_remaining_useful_life_m:delete',
        
        # Оставшийся срок полезного использования в годах
        'objects:exright_intellprop:destination:mss_objects_app:object:mss_od_remaining_useful_life_y:delete',


        # Удаление основного объекта
        'objects:exright_intellprop:destination:mss_objects:delete',
        'objects:exright_intellprop:destination:mss_objects_adr:delete',
        'objects:exright_intellprop:source:ids:drop___link_adr',
        'objects:exright_intellprop:destination:mss_adr:delete',

         # Удаление дополнительных колонок
        'objects:exright_intellprop:destination:mss_objects:drop___intellprop_sp',
        'objects:exright_intellprop:destination:mss_objects:drop___link_intellprop_sp',
        'objects:exright_intellprop:destination:mss_objects:drop___func_nazn_ei',
        'objects:exright_intellprop:destination:mss_objects:drop___link_func_nazn_ei',
        'objects:exright_intellprop:destination:mss_objects:drop___storage_authority_ei',
        'objects:exright_intellprop:destination:mss_objects:drop___link_storage_authority_ei',
      ]
    end
  end
end
