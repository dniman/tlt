Dir[File.expand_path('../section/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :section do
    task :import do
      Rake.invoke_task 'dictionaries:section:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:section:destination:mss_objects_dicts:delete',
    ]
  end
end
