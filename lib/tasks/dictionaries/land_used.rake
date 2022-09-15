Dir[File.expand_path('../land_used/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :land_used do
    task :import do
      Rake.invoke_task 'dictionaries:land_used:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:land_used:destination:mss_objects_dicts:delete',
    ]
  end
end
