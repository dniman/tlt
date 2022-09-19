Dir[File.expand_path('../unmovable_used/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :unmovable_used do
    task :import do
      Rake.invoke_task 'dictionaries:unmovable_used:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:unmovable_used:destination:mss_objects_dicts:delete',
    ]
  end
end
