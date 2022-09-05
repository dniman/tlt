Dir[File.expand_path('../land/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :land do
    task :tasks => [
      'import:land:source:ids:insert',
      'import:land:destination:mss_objects:add___oktmo', 
      'import:land:destination:mss_objects:add___kadastrno', 
      'import:land:source:ids:add___link_adr',
      'import:land:destination:mss_objects:insert', 
      'import:land:source:ids:update_link', 
      'import:land:source:ids:update___link_adr', 
      'import:land:destination:mss_objects:update_link_oktmo',
      'import:land:destination:mss_objects:update_inventar_num',
      'import:land:destination:mss_objects:drop___oktmo',
      'import:land:destination:mss_objects:add___cad_quorter', 
      'import:land:destination:mss_objects:update___cad_quorter',
      'import:land:destination:mss_objects_dicts:insert',
      'import:land:destination:mss_objects:update_link_cad_quorter',
      'import:land:destination:mss_objects:drop___cad_quorter',
      'import:land:destination:mss_objects:drop___kadastrno',
      'import:land:destination:mss_objects_adr:insert',
      'import:land:source:ids:drop___link_adr'
    ]
  end
end
