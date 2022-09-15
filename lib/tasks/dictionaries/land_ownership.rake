Dir[File.expand_path('../land_ownership/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :land_ownership do
    task :import do
      Rake.invoke_task 'dictionaries:land_ownership:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:land_ownership:destination:mss_objects_dicts:delete',
    ]
  end
end
