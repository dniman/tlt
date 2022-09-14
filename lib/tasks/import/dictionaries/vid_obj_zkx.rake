Dir[File.expand_path('../vid_obj_zkx/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :dictionaries do
    namespace :vid_obj_zkx do
      task :tasks => [
        'import:dictionaries:vid_obj_zkx:destination:mss_objects_dicts:insert',
      ]
    end
  end
end
