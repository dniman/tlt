Dir[File.expand_path('../construction/**/*.rake', __FILE__)].each {|path| import path}

namespace :destroy do
  namespace :construction do
    task :tasks => [
      'destroy:construction:destination:mss_objects:delete',
      'destroy:construction:destination:mss_objects:drop___cad_quorter',
      'destroy:construction:destination:mss_objects:drop___kadastrno',
      'destroy:construction:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
      'destroy:construction:destination:mss_objects_adr:delete',
      'destroy:construction:source:ids:drop___link_adr',
      'destroy:construction:destination:mss_adr:delete',
    ]
  end
end
