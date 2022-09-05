Dir[File.expand_path('../houses_life/**/*.rake', __FILE__)].each {|path| import path}

namespace :destroy do
  namespace :houses_life do
    task :tasks => [
      'destroy:houses_life:destination:mss_objects:delete',
      'destroy:houses_life:destination:mss_objects:drop___cad_quorter',
      'destroy:houses_life:destination:mss_objects:drop___kadastrno',
      'destroy:houses_life:destination:mss_objects_dicts:delete',
      'destroy:houses_life:destination:mss_objects_adr:delete',
      'destroy:houses_life:source:ids:drop___link_adr',
      'destroy:houses_life:destination:mss_adr:delete',
    ]
  end
end
