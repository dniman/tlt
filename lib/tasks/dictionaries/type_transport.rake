Dir[File.expand_path('../type_transport/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :type_transport do
    task :import do
      Rake.invoke_task 'dictionaries:type_transport:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:type_transport:destination:mss_objects_dicts:delete',
    ]
  end
end
