Dir[File.expand_path('../engine_type/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :engine_type do
    task :import do
      Rake.invoke_task 'dictionaries:engine_type:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:engine_type:destination:mss_objects_dicts:delete',
    ]
  end
end
