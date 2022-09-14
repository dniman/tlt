Dir[File.expand_path('../land_kateg/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :dictionaries do
    namespace :land_kateg do
      task :tasks => [
        'import:dictionaries:land_kateg:destination:mss_objects_dicts:insert',
      ]
    end
  end
end
