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
  ] 

end 

