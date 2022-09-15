Dir[File.expand_path('../unmovable_used_new/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :unmovable_used_new do
    task :import do
      Rake.invoke_task 'dictionaries:unmovable_used_new:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:unmovable_used_new:destination:mss_objects_dicts:delete',
    ]
  end
end
