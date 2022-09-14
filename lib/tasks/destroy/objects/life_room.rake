Dir[File.expand_path('../life_room/**/*.rake', __FILE__)].each {|path| import path}

namespace :destroy do
  namespace :life_room do
    task :tasks => [
      'destroy:life_room:destination:mss_objects:delete',
      'destroy:life_room:destination:mss_objects:drop___cad_quorter',
      'destroy:life_room:destination:mss_objects:drop___kadastrno',
      'destroy:life_room:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
      'destroy:life_room:destination:mss_objects_adr:delete',
      'destroy:life_room:source:ids:drop___link_adr',
      'destroy:life_room:destination:mss_adr:delete',
    ]
  end
end
