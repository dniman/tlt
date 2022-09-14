Dir[File.expand_path('../transition_rf_ms/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :dictionaries do
    namespace :transition_rf_ms do
      task :tasks => [
        'import:dictionaries:transition_rf_ms:destination:mss_objects_dicts:insert',
      ]
    end
  end
end
