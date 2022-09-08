Dir[File.expand_path('../land/**/*.rake', __FILE__)].each {|path| import path}

namespace :destroy do
  namespace :land do
    task :tasks => [
      'destroy:land:destination:mss_objects_app:add_hist:delete',
      'destroy:land:destination:mss_objects_app:land_pl:delete',
      'destroy:land:destination:mss_objects_app:obj_name_hist:delete',
      'destroy:land:destination:mss_objects_app:adr_str:delete',
      'destroy:land:destination:mss_objects_app:id_obj:delete',
      'destroy:land:destination:mss_objects_app:usl_n:delete',
      'destroy:land:destination:mss_objects_app:rn_old:delete',

      'destroy:land:destination:mss_objects:delete',
      'destroy:land:destination:mss_objects:drop___cad_quorter',
      'destroy:land:destination:mss_objects:drop___kadastrno',
      'destroy:land:destination:mss_objects:drop___oktmo',
      'destroy:land:destination:mss_objects_dicts:delete',
      'destroy:land:destination:mss_objects_adr:delete',
      'destroy:land:source:ids:drop___link_adr',
      'destroy:land:source:ids:drop___add_hist',
      'destroy:land:destination:mss_adr:delete',
    ]
  end
end
