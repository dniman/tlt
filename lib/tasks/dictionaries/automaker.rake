Dir[File.expand_path('../automaker/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :automaker do
    task :import do
      Rake.invoke_task 'dictionaries:automaker:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:automaker:destination:mss_objects_dicts:delete',
    ]
  end
end
