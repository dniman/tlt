Dir[File.expand_path('../**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :construction do
    namespace :import do
      task :tasks => [
        'objects:construction:source:ids:insert',
        'objects:construction:destination:mss_objects:add___kadastrno', 
        'objects:construction:source:ids:add___link_adr',
        'objects:construction:destination:mss_objects:insert', 
        'objects:construction:source:ids:update_link',
        'objects:construction:source:ids:update___link_adr',
        'objects:construction:destination:mss_objects:update_inventar_num',
        'objects:construction:destination:mss_objects:add___cad_quorter', 
        'objects:construction:destination:mss_objects:update___cad_quorter',
        'objects:construction:destination:mss_objects_dicts:object:dictionary_land_kvartals:insert',
        'objects:construction:destination:mss_objects:update_link_cad_quorter',
        'objects:construction:destination:mss_objects:drop___cad_quorter',
        'objects:construction:destination:mss_objects:drop___kadastrno',
        'objects:construction:destination:mss_objects_adr:insert',
        'objects:construction:source:ids:drop___link_adr'
      ]
    end
  end
end
