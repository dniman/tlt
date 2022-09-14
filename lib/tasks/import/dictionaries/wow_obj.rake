Dir[File.expand_path('../wow_obj/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :dictionaries do
    namespace :wow_obj do
      task :tasks => [
        'import:dictionaries:wow_obj:destination:mss_objects_dicts:insert',
      ]
    end
  end
end
