Dir[File.expand_path('../construction/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :construction do
    task :tasks => [
      'import:construction:source:ids:insert',
      'import:construction:destination:mss_objects:add___kadastrno', 
      'import:construction:source:ids:add___link_adr',
      'import:construction:destination:mss_objects:insert', 
      'import:construction:source:ids:update_link',
      'import:construction:source:ids:update___link_adr',
      'import:construction:destination:mss_objects:update_inventar_num',
      'import:construction:destination:mss_objects:add___cad_quorter', 
      'import:construction:destination:mss_objects:update___cad_quorter',
      'import:construction:destination:mss_objects_dicts:insert',
      'import:construction:destination:mss_objects:update_link_cad_quorter',
      'import:construction:destination:mss_objects:drop___cad_quorter',
      'import:construction:destination:mss_objects:drop___kadastrno',
      'import:construction:destination:mss_objects_adr:insert',
      'import:construction:source:ids:drop___link_adr'
    ]
  end
end
