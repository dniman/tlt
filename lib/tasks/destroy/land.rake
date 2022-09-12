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
      'destroy:land:destination:mss_objects_app:land_ownership:delete',
      'destroy:land:destination:mss_objects_app:transition_rf_ms:delete',
      'destroy:land:destination:mss_objects_app:land_kateg:delete',
      'destroy:land:destination:mss_objects_app:land_used:delete',
      'destroy:land:destination:mss_objects_app:unmovable_used_new:delete',

      'destroy:land:destination:mss_objects:delete',
      'destroy:land:destination:mss_objects:drop___cad_quorter',
      'destroy:land:destination:mss_objects:drop___kadastrno',
      'destroy:land:destination:mss_objects:drop___oktmo',
      'destroy:land:destination:mss_objects:drop___land_ownership',
      'destroy:land:destination:mss_objects:drop___link_land_ownership',
      'destroy:land:destination:mss_objects:drop___transition_rf_ms',
      'destroy:land:destination:mss_objects:drop___link_transition_rf_ms',
      'destroy:land:destination:mss_objects:drop___land_kateg',
      'destroy:land:destination:mss_objects:drop___link_land_kateg',
      'destroy:land:destination:mss_objects:drop___land_used',
      'destroy:land:destination:mss_objects:drop___link_land_used',
      'destroy:land:destination:mss_objects:drop___unmovable_used_new',
      'destroy:land:destination:mss_objects:drop___link_unmovable_used_new',
      'destroy:land:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
      'destroy:land:destination:mss_objects_dicts:link_type:land_ownership:delete',
      'destroy:land:destination:mss_objects_dicts:link_type:transition_rf_ms:delete',
      'destroy:land:destination:mss_objects_dicts:link_type:land_used:delete',
      'destroy:land:destination:mss_objects_dicts:link_type:unmovable_used_new:delete',
      'destroy:land:destination:mss_objects_adr:delete',
      'destroy:land:source:ids:drop___link_adr',
      'destroy:land:source:ids:drop___add_hist',
      'destroy:land:source:ids:drop___adr_str',
      'destroy:land:destination:mss_adr:delete',
    ]
  end
end
