Dir[File.expand_path('../mss_dict_decommission_causes/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :mss_dict_decommission_causes do
    task :import do
      Rake.invoke_task 'dictionaries:mss_dict_decommission_causes:source:___mss_dict_decommission_causes:create_table', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:mss_dict_decommission_causes:source:___mss_dict_decommission_causes:insert', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:mss_dict_decommission_causes:source:___ids:insert', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:mss_dict_decommission_causes:destination:mss_decommission_causes:insert'
      Rake.invoke_task 'dictionaries:mss_dict_decommission_causes:source:___ids:update_link'
    end 
    
    task :destroy => [
      'dictionaries:mss_dict_decommission_causes:destination:___del_ids:insert',
      'dictionaries:mss_dict_decommission_causes:destination:mss_decommission_causes:delete',
      'dictionaries:mss_dict_decommission_causes:destination:___del_ids:delete'
    ]
  end
end
