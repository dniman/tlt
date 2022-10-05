Dir[File.expand_path('../auto_country_export/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :auto_country_export do
    task :import do
      Rake.invoke_task 'dictionaries:auto_country_export:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:auto_country_export:destination:mss_objects_dicts:delete',
    ]
  end
end
