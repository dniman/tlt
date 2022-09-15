Dir[File.expand_path('../vid_obj_zkx/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :vid_obj_zkx do
    task :import do
      Rake.invoke_task 'dictionaries:vid_obj_zkx:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:vid_obj_zkx:destination:mss_objects_dicts:delete',
    ]
  end
end
