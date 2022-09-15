Dir[File.expand_path('../transition_rf_ms/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :transition_rf_ms do
    task :import do
      Rake.invoke_task 'dictionaries:transition_rf_ms:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:transition_rf_ms:destination:mss_objects_dicts:delete',
    ]
  end
end
