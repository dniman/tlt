Dir[File.expand_path('../unfinished/**/*.rake', __FILE__)].each {|path| import path}

namespace :destroy do
  namespace :unfinished do
    task :tasks => [
      'destroy:unfinished:destination:mss_objects:delete',
      'destroy:unfinished:destination:mss_objects:drop___cad_quorter',
      'destroy:unfinished:destination:mss_objects:drop___kadastrno',
      'destroy:unfinished:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
      'destroy:unfinished:destination:mss_objects_adr:delete',
      'destroy:unfinished:source:ids:drop___link_adr',
      'destroy:unfinished:destination:mss_adr:delete',
    ]
  end
end
