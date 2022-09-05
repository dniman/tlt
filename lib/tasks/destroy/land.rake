Dir[File.expand_path('../land/**/*.rake', __FILE__)].each {|path| import path}

namespace :destroy do
  namespace :land do
    task :tasks => [
      'destroy:land:destination:mss_objects:delete',
      'destroy:land:destination:mss_objects:drop___cad_quorter',
      'destroy:land:destination:mss_objects:drop___kadastrno',
      'destroy:land:destination:mss_objects:drop___oktmo',
      'destroy:land:destination:mss_objects_dicts:delete',
      'destroy:land:destination:mss_objects_adr:delete',
      'destroy:land:source:ids:drop___link_adr',
      'destroy:land:destination:mss_adr:delete',
    ]
  end
end
