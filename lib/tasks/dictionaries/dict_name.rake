Dir[File.expand_path('../dict_name/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :dict_name do
    task :import do
      Rake.invoke_task 'dictionaries:dict_name:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:dict_name:destination:mss_objects_dicts:delete',
    ]
  end
end
