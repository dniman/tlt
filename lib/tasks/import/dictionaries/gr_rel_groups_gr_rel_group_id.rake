Dir[File.expand_path('../gr_rel_groups_gr_rel_group_id/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :dictionaries do
    namespace :gr_rel_groups_gr_rel_group_id do
      task :tasks => [
        'import:dictionaries:gr_rel_groups_gr_rel_group_id:destination:mss_objects_dicts:insert',
      ]
    end
  end
end
