Dir[File.expand_path('../life_room/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :life_room do
    task :tasks => [
      'import:life_room:source:ids:insert',
      'import:life_room:destination:mss_objects:add___kadastrno', 
      'import:life_room:source:ids:add___link_adr',
      'import:life_room:destination:mss_objects:insert', 
      'import:life_room:source:ids:update_link',
      'import:life_room:source:ids:update___link_adr',
      'import:life_room:destination:mss_objects:update_inventar_num',
      'import:life_room:destination:mss_objects:add___cad_quorter', 
      'import:life_room:destination:mss_objects:update___cad_quorter',
      'import:life_room:destination:mss_objects_dicts:object:dictionary_land_kvartals:insert',
      'import:life_room:destination:mss_objects:update_link_cad_quorter',
      'import:life_room:destination:mss_objects:drop___cad_quorter',
      'import:life_room:destination:mss_objects:drop___kadastrno',
      'import:life_room:destination:mss_objects_adr:insert',
      'import:life_room:source:ids:drop___link_adr'
    ]
  end
end
