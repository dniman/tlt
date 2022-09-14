import 'lib/tasks/import/dictionaries/land_ownership.rake'
import 'lib/tasks/import/dictionaries/transition_rf_ms.rake'
import 'lib/tasks/import/dictionaries/land_kateg.rake'
import 'lib/tasks/import/dictionaries/land_used.rake'
import 'lib/tasks/import/dictionaries/unmovable_used_new.rake'
import 'lib/tasks/import/dictionaries/grounds_release_release_id.rake'
import 'lib/tasks/import/dictionaries/gr_rel_groups_gr_rel_group_id.rake'
import 'lib/tasks/import/dictionaries/target_doc_target_doc_id.rake'
import 'lib/tasks/import/dictionaries/grounds_funk_using_grounds_funk_using_id.rake'
import 'lib/tasks/import/dictionaries/wow_obj.rake'
import 'lib/tasks/import/dictionaries/soc_zn_obj.rake'
import 'lib/tasks/import/dictionaries/obj_zkx.rake'
import 'lib/tasks/import/dictionaries/vid_obj_zkx.rake'

namespace :import do
  namespace :dictionaries do

    task :tasks => [
      'import:dictionaries:land_ownership:tasks',
      'import:dictionaries:transition_rf_ms:tasks',
      'import:dictionaries:land_kateg:tasks',
      'import:dictionaries:land_used:tasks',
      'import:dictionaries:unmovable_used_new:tasks',
      'import:dictionaries:grounds_release_release_id:tasks',
      'import:dictionaries:gr_rel_groups_gr_rel_group_id:tasks',
      'import:dictionaries:target_doc_target_doc_id:tasks',
      'import:dictionaries:grounds_funk_using_grounds_funk_using_id:tasks',
      'import:dictionaries:wow_obj:tasks',
      'import:dictionaries:soc_zn_obj:tasks',
      'import:dictionaries:obj_zkx:tasks',
      'import:dictionaries:vid_obj_zkx:tasks',
    ] 
  end 
end

