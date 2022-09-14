Dir[File.expand_path('../land_ownership/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :dictionaries do
    namespace :land_ownership do
      task :tasks => [
        'import:dictionaries:land_ownership:destination:mss_objects_dicts:insert',
      ]
    end
  end
end
