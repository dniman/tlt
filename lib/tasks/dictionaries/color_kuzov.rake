Dir[File.expand_path('../color_kuzov/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :color_kuzov do
    task :import do
      Rake.invoke_task 'dictionaries:color_kuzov:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:color_kuzov:destination:mss_objects_dicts:delete',
    ]
  end
end
