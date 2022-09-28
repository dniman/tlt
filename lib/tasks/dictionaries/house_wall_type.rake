Dir[File.expand_path('../house_wall_type/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :house_wall_type do
    task :import do
      Rake.invoke_task 'dictionaries:house_wall_type:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:house_wall_type:destination:mss_objects_dicts:delete',
    ]
  end
end
