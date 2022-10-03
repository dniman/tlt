Dir[File.expand_path('../group/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :group do
    task :import do
      Rake.invoke_task 'dictionaries:group:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:group:destination:mss_objects_dicts:delete',
    ]
  end
end
