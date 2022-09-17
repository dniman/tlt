namespace :objects do
  namespace :construction do
    namespace :import do

      task :tasks do
        Rake.invoke_task 'objects:construction:source:ids:insert'
        Rake.invoke_task 'objects:construction:destination:mss_objects:add___kadastrno'
        Rake.invoke_task 'objects:construction:source:ids:add___link_adr'
        Rake.invoke_task 'objects:construction:destination:mss_objects:insert'
        Rake.invoke_task 'objects:construction:source:ids:update_link'
        Rake.invoke_task 'objects:construction:source:ids:update___link_adr'
        Rake.invoke_task 'objects:construction:destination:mss_objects:update_inventar_num'
        Rake.invoke_task 'objects:construction:destination:mss_objects:add___cad_quorter' 
        Rake.invoke_task 'objects:construction:destination:mss_objects:update___cad_quorter'
        Rake.invoke_task 'objects:construction:destination:mss_objects_dicts:object:dictionary_land_kvartals:insert'
        Rake.invoke_task 'objects:construction:destination:mss_objects:update_link_cad_quorter'
        Rake.invoke_task 'objects:construction:destination:mss_objects:drop___cad_quorter'
        Rake.invoke_task 'objects:construction:destination:mss_objects:drop___kadastrno'
        Rake.invoke_task 'objects:construction:destination:mss_objects_adr:insert'
        Rake.invoke_task 'objects:construction:source:ids:drop___link_adr'
        
        # История адреса
        Rake.invoke_task 'objects:construction:source:ids:add___add_hist'
        Rake.invoke_task 'objects:construction:source:ids:update___add_hist'
        Rake.invoke_task 'objects:construction:destination:mss_objects_app:add_hist:insert'
        Rake.invoke_task 'objects:construction:source:ids:drop___add_hist'
        
        # История наименования
        Rake.invoke_task 'objects:construction:destination:mss_objects_app:obj_name_hist:insert'
        
        # Официальный адрес
        Rake.invoke_task 'objects:construction:source:ids:add___adr_str'
        Rake.invoke_task 'objects:construction:source:ids:update___adr_str'
        Rake.invoke_task 'objects:construction:destination:mss_objects_app:adr_str:insert'
        Rake.invoke_task 'objects:construction:source:ids:drop___adr_str'
        
        # Общая площадь
        Rake.invoke_task 'objects:construction:destination:mss_objects_app:house_pl:insert'

        # ID объекта из Сауми
        Rake.invoke_task 'objects:construction:destination:mss_objects_app:id_obj:insert'
      end 
    end

  end
end
