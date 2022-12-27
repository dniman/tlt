Dir[File.expand_path('../mkd_code/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :mkd_code do
    task :import do
      Rake.invoke_task 'dictionaries:mkd_code:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:mkd_code:destination:mss_objects_dicts:delete',
    ]
  end
end
