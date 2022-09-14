Dir[File.expand_path('../**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :unfinished do
    namespace :import do
      task :tasks => [
        'objects:unfinished:source:ids:insert',
        'objects:unfinished:destination:mss_objects:add___kadastrno', 
        'objects:unfinished:source:ids:add___link_adr',
        'objects:unfinished:destination:mss_objects:insert', 
        'objects:unfinished:source:ids:update_link',
        'objects:unfinished:source:ids:update___link_adr',
        'objects:unfinished:destination:mss_objects:update_inventar_num',
        'objects:unfinished:destination:mss_objects:add___cad_quorter', 
        'objects:unfinished:destination:mss_objects:update___cad_quorter',
        'objects:unfinished:destination:mss_objects_dicts:object:dictionary_land_kvartals:insert',
        'objects:unfinished:destination:mss_objects:update_link_cad_quorter',
        'objects:unfinished:destination:mss_objects:drop___cad_quorter',
        'objects:unfinished:destination:mss_objects:drop___kadastrno',
        'objects:unfinished:destination:mss_objects_adr:insert',
        'objects:unfinished:source:ids:drop___link_adr'
      ]
    end
  end
end
