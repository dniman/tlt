Dir[File.expand_path('../vri_avtodor/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :vri_avtodor do
    task :import do
      Rake.invoke_task 'dictionaries:vri_avtodor:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:vri_avtodor:destination:mss_objects_dicts:delete',
    ]
  end
end
