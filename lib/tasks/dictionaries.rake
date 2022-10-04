import 'lib/tasks/dictionaries/land_ownership.rake'
import 'lib/tasks/dictionaries/transition_rf_ms.rake'
import 'lib/tasks/dictionaries/land_kateg.rake'
import 'lib/tasks/dictionaries/land_used.rake'
import 'lib/tasks/dictionaries/unmovable_used_new.rake'
import 'lib/tasks/dictionaries/grounds_release_release_id.rake'
import 'lib/tasks/dictionaries/gr_rel_groups_gr_rel_group_id.rake'
import 'lib/tasks/dictionaries/target_doc_target_doc_id.rake'
import 'lib/tasks/dictionaries/grounds_funk_using_grounds_funk_using_id.rake'
import 'lib/tasks/dictionaries/wow_obj.rake'
import 'lib/tasks/dictionaries/soc_zn_obj.rake'
import 'lib/tasks/dictionaries/obj_zkx.rake'
import 'lib/tasks/dictionaries/vid_obj_zkx.rake'
import 'lib/tasks/dictionaries/house_material.rake'
import 'lib/tasks/dictionaries/is_immovable.rake'
import 'lib/tasks/dictionaries/culturial_sense.rake'
import 'lib/tasks/dictionaries/unmovable_used.rake'
import 'lib/tasks/dictionaries/vri_avtodor.rake'
import 'lib/tasks/dictionaries/klass_avtodor.rake'
import 'lib/tasks/dictionaries/kateg_avtodor.rake'
import 'lib/tasks/dictionaries/group_im.rake'
import 'lib/tasks/dictionaries/doc.rake'
import 'lib/tasks/dictionaries/kbk.rake'
import 'lib/tasks/dictionaries/house_wall_type.rake'
import 'lib/tasks/dictionaries/dict_name.rake'
import 'lib/tasks/dictionaries/group.rake'
import 'lib/tasks/dictionaries/section.rake'
import 'lib/tasks/dictionaries/type_transport.rake'
import 'lib/tasks/dictionaries/automaker.rake'
import 'lib/tasks/dictionaries/color_kuzov.rake'
import 'lib/tasks/dictionaries/engine_type.rake'
import 'lib/tasks/dictionaries/auto_country.rake'

namespace :dictionaries do

  task :import => [
    'dictionaries:land_ownership:import',
    'dictionaries:transition_rf_ms:import',
    'dictionaries:land_kateg:import',
    'dictionaries:land_used:import',
    'dictionaries:unmovable_used_new:import',
    'dictionaries:grounds_release_release_id:import',
    'dictionaries:gr_rel_groups_gr_rel_group_id:import',
    'dictionaries:target_doc_target_doc_id:import',
    'dictionaries:grounds_funk_using_grounds_funk_using_id:import',
    'dictionaries:wow_obj:import',
    'dictionaries:soc_zn_obj:import',
    'dictionaries:obj_zkx:import',
    'dictionaries:vid_obj_zkx:import',
    'dictionaries:house_material:import',
    'dictionaries:is_immovable:import',
    'dictionaries:culturial_sense:import',
    'dictionaries:unmovable_used:import',
    'dictionaries:vri_avtodor:import',
    'dictionaries:klass_avtodor:import',
    'dictionaries:kateg_avtodor:import',
    'dictionaries:group_im:import',
    'dictionaries:doc:import',
    'dictionaries:kbk:import',
    'dictionaries:house_wall_type:import',
    'dictionaries:dict_name:import',
    'dictionaries:group:import',
    'dictionaries:section:import',
    'dictionaries:type_transport:import',
    'dictionaries:automaker:import',
    'dictionaries:color_kuzov:import',
    'dictionaries:engine_type:import',
    'dictionaries:auto_country:import',
  ] 

  task :destroy => [
    'dictionaries:land_ownership:destroy',
    'dictionaries:transition_rf_ms:destroy',
    'dictionaries:land_kateg:destroy',
    'dictionaries:land_used:destroy',
    'dictionaries:unmovable_used_new:destroy',
    'dictionaries:grounds_release_release_id:destroy',
    'dictionaries:gr_rel_groups_gr_rel_group_id:destroy',
    'dictionaries:target_doc_target_doc_id:destroy',
    'dictionaries:grounds_funk_using_grounds_funk_using_id:destroy',
    'dictionaries:wow_obj:destroy',
    'dictionaries:soc_zn_obj:destroy',
    'dictionaries:obj_zkx:destroy',
    'dictionaries:vid_obj_zkx:destroy',
    'dictionaries:house_material:destroy',
    'dictionaries:is_immovable:destroy',
    'dictionaries:culturial_sense:destroy',
    'dictionaries:unmovable_used:destroy',
    'dictionaries:vri_avtodor:destroy',
    'dictionaries:klass_avtodor:destroy',
    'dictionaries:kateg_avtodor:destroy',
    'dictionaries:group_im:destroy',
    'dictionaries:doc:destroy',
    'dictionaries:kbk:destroy',
    'dictionaries:house_wall_type:destroy',
    'dictionaries:dict_name:destroy',
    'dictionaries:group:destroy',
    'dictionaries:section:destroy',
    'dictionaries:type_transport:destroy',
    'dictionaries:automaker:destroy',
    'dictionaries:color_kuzov:destroy',
    'dictionaries:engine_type:destroy',
    'dictionaries:auto_country:destroy',
  ] 

end 

