Dir[File.expand_path('../houses_life/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :houses_life do
    task :tasks => [
      'import:houses_life:source:ids:insert',
      'import:houses_life:destination:mss_objects:add___kadastrno', 
      'import:houses_life:source:ids:add___link_adr',
      'import:houses_life:destination:mss_objects:insert', 
      'import:houses_life:source:ids:update_link',
      'import:houses_life:source:ids:update___link_adr',
      'import:houses_life:destination:mss_objects:update_inventar_num',
      'import:houses_life:destination:mss_objects:add___cad_quorter', 
      'import:houses_life:destination:mss_objects:update___cad_quorter',
      'import:houses_life:destination:mss_objects_dicts:object:dictionary_land_kvartals:insert',
      'import:houses_life:destination:mss_objects:update_link_cad_quorter',
      'import:houses_life:destination:mss_objects:drop___cad_quorter',
      'import:houses_life:destination:mss_objects:drop___kadastrno',
      'import:houses_life:destination:mss_objects_adr:insert',
      'import:houses_life:source:ids:drop___link_adr'
    ]
  end
end
