Dir[File.expand_path('../**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :life_room do
    namespace :import do
      task :tasks => [
        'objects:life_room:source:ids:insert',
        'objects:life_room:destination:mss_objects:add___kadastrno', 
        'objects:life_room:source:ids:add___link_adr',
        'objects:life_room:destination:mss_objects:insert', 
        'objects:life_room:source:ids:update_link',
        'objects:life_room:source:ids:update___link_adr',
        'objects:life_room:destination:mss_objects:update_inventar_num',
        'objects:life_room:destination:mss_objects:add___cad_quorter', 
        'objects:life_room:destination:mss_objects:update___cad_quorter',
        'objects:life_room:destination:mss_objects_dicts:object:dictionary_land_kvartals:insert',
        'objects:life_room:destination:mss_objects:update_link_cad_quorter',
        'objects:life_room:destination:mss_objects:drop___cad_quorter',
        'objects:life_room:destination:mss_objects:drop___kadastrno',
        'objects:life_room:destination:mss_objects_adr:insert',
        'objects:life_room:source:ids:drop___link_adr'
      ]
    end
  end
end