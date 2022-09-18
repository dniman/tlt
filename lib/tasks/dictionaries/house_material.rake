Dir[File.expand_path('../house_material/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :house_material do
    task :import do
      Rake.invoke_task 'dictionaries:house_material:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:house_material:destination:mss_objects_dicts:delete',
    ]
  end
end
