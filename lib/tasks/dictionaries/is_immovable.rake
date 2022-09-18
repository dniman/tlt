Dir[File.expand_path('../is_immovable/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :is_immovable do
    task :import do
      Rake.invoke_task 'dictionaries:is_immovable:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:is_immovable:destination:mss_objects_dicts:delete',
    ]
  end
end
