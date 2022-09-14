Dir[File.expand_path('../**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :houses_life do
    namespace :import do
      task :tasks => [
        'objects:houses_life:source:ids:insert',
        'objects:houses_life:destination:mss_objects:add___kadastrno', 
        'objects:houses_life:source:ids:add___link_adr',
        'objects:houses_life:destination:mss_objects:insert', 
        'objects:houses_life:source:ids:update_link',
        'objects:houses_life:source:ids:update___link_adr',
        'objects:houses_life:destination:mss_objects:update_inventar_num',
        'objects:houses_life:destination:mss_objects:add___cad_quorter', 
        'objects:houses_life:destination:mss_objects:update___cad_quorter',
        'objects:houses_life:destination:mss_objects_dicts:object:dictionary_land_kvartals:insert',
        'objects:houses_life:destination:mss_objects:update_link_cad_quorter',
        'objects:houses_life:destination:mss_objects:drop___cad_quorter',
        'objects:houses_life:destination:mss_objects:drop___kadastrno',
        'objects:houses_life:destination:mss_objects_adr:insert',
        'objects:houses_life:source:ids:drop___link_adr'
      ]
    end
  end
end
