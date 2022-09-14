Dir[File.expand_path('../transition_rf_ms/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :transition_rf_ms do
    task :import => [
      'dictionaries:transition_rf_ms:destination:mss_objects_dicts:insert',
    ]
    
    task :destroy => [
      'dictionaries:transition_rf_ms:destination:mss_objects_dicts:delete',
    ]
  end
end
