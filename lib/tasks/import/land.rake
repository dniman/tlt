Dir[File.expand_path('../land/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :land do
    task :tasks => [
      'import:land:source:ids:insert',
      'import:land:destination:mss_objects:add___oktmo', 
      'import:land:destination:mss_objects:add___kadastrno', 
      'import:land:source:ids:add___link_adr',
      'import:land:destination:mss_objects:insert', 
      'import:land:source:ids:update_link', 
      'import:land:source:ids:update___link_adr', 
      'import:land:destination:mss_objects:update_link_oktmo',
      'import:land:destination:mss_objects:update_inventar_num',
      'import:land:destination:mss_objects:drop___oktmo',
      'import:land:destination:mss_objects:add___cad_quorter', 
      'import:land:destination:mss_objects:update___cad_quorter',
      'import:land:destination:mss_objects_dicts:insert',
      'import:land:destination:mss_objects:update_link_cad_quorter',
      'import:land:destination:mss_objects:drop___cad_quorter',
      'import:land:destination:mss_objects:drop___kadastrno',
      'import:land:destination:mss_objects_adr:insert',
      'import:land:destination:mss_adr:update',
      'import:land:source:ids:drop___link_adr',
      'import:land:source:ids:add___add_hist',
      'import:land:source:ids:update___add_hist',
      'import:land:destination:mss_objects_app:add_hist:insert',
      'import:land:source:ids:drop___add_hist',
      'import:land:destination:mss_objects_app:obj_name_hist:insert',
      'import:land:destination:mss_objects_app:land_pl:insert',
      'import:land:source:ids:add___adr_str',
      'import:land:source:ids:update___adr_str',
      'import:land:destination:mss_objects_app:adr_str:insert',
      'import:land:source:ids:drop___adr_str',
      'import:land:destination:mss_objects_app:id_obj:insert',
      'import:land:destination:mss_objects_app:usl_n:insert',
      'import:land:destination:mss_objects_app:rn_old:insert',
    ]
  end
end
