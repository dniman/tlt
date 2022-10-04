Dir[File.expand_path('../auto_country/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :auto_country do
    task :import do
      Rake.invoke_task 'dictionaries:auto_country:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:auto_country:destination:mss_objects_dicts:delete',
    ]
  end
end
