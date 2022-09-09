Dir[File.expand_path('../unfinished/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :unfinished do
    task :tasks => [
      'import:unfinished:source:ids:insert',
      'import:unfinished:destination:mss_objects:add___kadastrno', 
      'import:unfinished:source:ids:add___link_adr',
      'import:unfinished:destination:mss_objects:insert', 
      'import:unfinished:source:ids:update_link',
      'import:unfinished:source:ids:update___link_adr',
      'import:unfinished:destination:mss_objects:update_inventar_num',
      'import:unfinished:destination:mss_objects:add___cad_quorter', 
      'import:unfinished:destination:mss_objects:update___cad_quorter',
      'import:unfinished:destination:mss_objects_dicts:object:dictionary_land_kvartals:insert',
      'import:unfinished:destination:mss_objects:update_link_cad_quorter',
      'import:unfinished:destination:mss_objects:drop___cad_quorter',
      'import:unfinished:destination:mss_objects:drop___kadastrno',
      'import:unfinished:destination:mss_objects_adr:insert',
      'import:unfinished:source:ids:drop___link_adr'
    ]
  end
end
