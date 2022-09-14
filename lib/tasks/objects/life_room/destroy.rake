Dir[File.expand_path('../**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :life_room do
    namespace :destroy do
      task :tasks => [
        'objects:life_room:destination:mss_objects:delete',
        'objects:life_room:destination:mss_objects:drop___cad_quorter',
        'objects:life_room:destination:mss_objects:drop___kadastrno',
        'objects:life_room:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:life_room:destination:mss_objects_adr:delete',
        'objects:life_room:source:ids:drop___link_adr',
        'objects:life_room:destination:mss_adr:delete',
      ]
    end
  end
end
