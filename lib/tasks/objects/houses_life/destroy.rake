Dir[File.expand_path('../**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :houses_life do
    namespace :destroy do
      task :tasks => [
        'objects:houses_life:destination:mss_objects:delete',
        'objects:houses_life:destination:mss_objects:drop___cad_quorter',
        'objects:houses_life:destination:mss_objects:drop___kadastrno',
        'objects:houses_life:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:houses_life:destination:mss_objects_adr:delete',
        'objects:houses_life:source:ids:drop___link_adr',
        'objects:houses_life:destination:mss_adr:delete',
      ]
    end
  end
end
