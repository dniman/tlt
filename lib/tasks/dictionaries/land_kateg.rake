Dir[File.expand_path('../land_kateg/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :land_kateg do
    task :import do
      Rake.invoke_task 'dictionaries:land_kateg:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:land_kateg:destination:mss_objects_dicts:delete',
    ]
  end
end
