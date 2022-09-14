Dir[File.expand_path('../houses_unlife/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :houses_unlife do
    task :tasks => [
      'import:houses_unlife:source:ids:insert',
      'import:houses_unlife:destination:mss_objects:add___kadastrno', 
      'import:houses_unlife:source:ids:add___link_adr',
      'import:houses_unlife:destination:mss_objects:insert', 
      'import:houses_unlife:source:ids:update_link',
      'import:houses_unlife:source:ids:update___link_adr',
      'import:houses_unlife:destination:mss_objects:update_inventar_num',
      'import:houses_unlife:destination:mss_objects:add___cad_quorter', 
      'import:houses_unlife:destination:mss_objects:update___cad_quorter',
      'import:houses_unlife:destination:mss_objects_dicts:object:dictionary_land_kvartals:insert',
      'import:houses_unlife:destination:mss_objects:update_link_cad_quorter',
      'import:houses_unlife:destination:mss_objects:drop___cad_quorter',
      'import:houses_unlife:destination:mss_objects:drop___kadastrno',
      'import:houses_unlife:destination:mss_objects_adr:insert',
      'import:houses_unlife:source:ids:drop___link_adr'
    ]
  end
end
