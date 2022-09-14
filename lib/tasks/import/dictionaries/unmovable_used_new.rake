Dir[File.expand_path('../unmovable_used_new/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :dictionaries do
    namespace :unmovable_used_new do
      task :tasks => [
        'import:dictionaries:unmovable_used_new:destination:mss_objects_dicts:insert',
      ]
    end
  end
end
