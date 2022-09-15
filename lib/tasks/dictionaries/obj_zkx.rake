Dir[File.expand_path('../obj_zkx/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :obj_zkx do
    task :import do
      Rake.invoke_task 'dictionaries:obj_zkx:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:obj_zkx:destination:mss_objects_dicts:delete',
    ]
  end
end
