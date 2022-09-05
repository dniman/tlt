Dir[File.expand_path('../unlife_room/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :unlife_room do
    task :tasks => [
      'import:unlife_room:source:ids:insert',
      'import:unlife_room:destination:mss_objects:add___kadastrno', 
      'import:unlife_room:source:ids:add___link_adr',
      'import:unlife_room:destination:mss_objects:insert', 
      'import:unlife_room:source:ids:update_link',
      'import:unlife_room:source:ids:update___link_adr',
      'import:unlife_room:destination:mss_objects:update_inventar_num',
      'import:unlife_room:destination:mss_objects:add___cad_quorter', 
      'import:unlife_room:destination:mss_objects:update___cad_quorter',
      'import:unlife_room:destination:mss_objects_dicts:insert',
      'import:unlife_room:destination:mss_objects:update_link_cad_quorter',
      'import:unlife_room:destination:mss_objects:drop___cad_quorter',
      'import:unlife_room:destination:mss_objects:drop___kadastrno',
      'import:unlife_room:destination:mss_objects_adr:insert',
      'import:unlife_room:source:ids:drop___link_adr'
    ]
  end
end
