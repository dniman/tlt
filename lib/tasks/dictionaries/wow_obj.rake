Dir[File.expand_path('../wow_obj/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :wow_obj do
    task :import do
      Rake.invoke_task 'dictionaries:wow_obj:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:wow_obj:destination:mss_objects_dicts:delete',
    ]
  end
end
