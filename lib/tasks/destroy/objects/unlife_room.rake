Dir[File.expand_path('../unlife_room/**/*.rake', __FILE__)].each {|path| import path}

namespace :destroy do
  namespace :unlife_room do
    task :tasks => [
      'destroy:unlife_room:destination:mss_objects:delete',
      'destroy:unlife_room:destination:mss_objects:drop___cad_quorter',
      'destroy:unlife_room:destination:mss_objects:drop___kadastrno',
      'destroy:unlife_room:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
      'destroy:unlife_room:destination:mss_objects_adr:delete',
      'destroy:unlife_room:source:ids:drop___link_adr',
      'destroy:unlife_room:destination:mss_adr:delete',
    ]
  end
end
