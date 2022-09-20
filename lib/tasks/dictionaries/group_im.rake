Dir[File.expand_path('../group_im/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :group_im do
    task :import do
      Rake.invoke_task 'dictionaries:group_im:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:group_im:destination:mss_objects_dicts:delete',
    ]
  end
end
