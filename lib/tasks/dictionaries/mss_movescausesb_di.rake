Dir[File.expand_path('../mss_movescausesb_di/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :mss_movescausesb_di do
    task :import do
      Rake.invoke_task 'dictionaries:mss_movescausesb_di:source:___mss_movescausesb_di:create_table', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:mss_movescausesb_di:source:___mss_movescausesb_di:insert', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:mss_movescausesb_di:source:___ids:insert', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:mss_movescausesb_di:destination:mss_moves_causes_b:insert'
      Rake.invoke_task 'dictionaries:mss_movescausesb_di:source:___ids:update_link'
    end 
    
    task :destroy => [
      'dictionaries:mss_movescausesb_di:destination:___del_ids:insert',
      'dictionaries:mss_movescausesb_di:destination:mss_moves_causes_b:delete',
      'dictionaries:mss_movescausesb_di:destination:___del_ids:delete'
    ]
  end
end
