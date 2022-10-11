Dir[File.expand_path('../state/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :state do
    task :import do
      Rake.invoke_task 'dictionaries:state:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:state:destination:mss_objects_dicts:delete',
    ]
  end
end
