Dir[File.expand_path('../land_used/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :dictionaries do
    namespace :land_used do
      task :tasks => [
        'import:dictionaries:land_used:destination:mss_objects_dicts:insert',
      ]
    end
  end
end
