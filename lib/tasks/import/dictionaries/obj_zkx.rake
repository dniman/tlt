Dir[File.expand_path('../obj_zkx/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :dictionaries do
    namespace :obj_zkx do
      task :tasks => [
        'import:dictionaries:obj_zkx:destination:mss_objects_dicts:insert',
      ]
    end
  end
end
