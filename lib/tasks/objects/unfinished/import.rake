Dir[File.expand_path('../**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :unfinished do
    namespace :import do

      task :tasks do
        Rake.invoke_task 'objects:unfinished:source:ids:insert'
        Rake.invoke_task 'objects:unfinished:destination:mss_objects:add___kadastrno' 
        Rake.invoke_task 'objects:unfinished:source:ids:add___link_adr'
        Rake.invoke_task 'objects:unfinished:destination:mss_objects:insert' 
        Rake.invoke_task 'objects:unfinished:source:ids:update_link'
        Rake.invoke_task 'objects:unfinished:source:ids:update___link_adr'
        Rake.invoke_task 'objects:unfinished:destination:mss_objects:update_inventar_num'
        Rake.invoke_task 'objects:unfinished:destination:mss_objects:add___cad_quorter' 
        Rake.invoke_task 'objects:unfinished:destination:mss_objects:update___cad_quorter'
        Rake.invoke_task 'objects:unfinished:destination:mss_objects_dicts:object:dictionary_land_kvartals:insert'
        Rake.invoke_task 'objects:unfinished:destination:mss_objects:update_link_cad_quorter'
        Rake.invoke_task 'objects:unfinished:destination:mss_objects:drop___cad_quorter'
        Rake.invoke_task 'objects:unfinished:destination:mss_objects:drop___kadastrno'
        Rake.invoke_task 'objects:unfinished:destination:mss_objects_adr:insert'
        Rake.invoke_task 'objects:unfinished:source:ids:drop___link_adr'
      end 

    end
  end
end
