Dir[File.expand_path('../culturial_sense/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :culturial_sense do
    task :import do
      Rake.invoke_task 'dictionaries:culturial_sense:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:culturial_sense:destination:mss_objects_dicts:delete',
    ]
  end
end
