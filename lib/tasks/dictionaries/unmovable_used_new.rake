Dir[File.expand_path('../unmovable_used_new/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :unmovable_used_new do
    task :import => [
      'dictionaries:unmovable_used_new:destination:mss_objects_dicts:insert',
    ]
    
    task :destroy => [
      'dictionaries:unmovable_used_new:destination:mss_objects_dicts:delete',
    ]
  end
end
