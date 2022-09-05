Dir[File.expand_path('../houses_unlife/**/*.rake', __FILE__)].each {|path| import path}

namespace :destroy do
  namespace :houses_unlife do
    task :tasks => [
      'destroy:houses_unlife:destination:mss_objects:delete',
      'destroy:houses_unlife:destination:mss_objects:drop___cad_quorter',
      'destroy:houses_unlife:destination:mss_objects:drop___kadastrno',
      'destroy:houses_unlife:destination:mss_objects_dicts:delete',
      'destroy:houses_unlife:destination:mss_objects_adr:delete',
      'destroy:houses_unlife:source:ids:drop___link_adr',
      'destroy:houses_unlife:destination:mss_adr:delete',
    ]
  end
end
