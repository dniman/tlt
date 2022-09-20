Dir[File.expand_path('../kateg_avtodor/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :kateg_avtodor do
    task :import do
      Rake.invoke_task 'dictionaries:kateg_avtodor:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:kateg_avtodor:destination:mss_objects_dicts:delete',
    ]
  end
end
