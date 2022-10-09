Dir[File.expand_path('../intellprop_sp/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :intellprop_sp do
    task :import do
      Rake.invoke_task 'dictionaries:intellprop_sp:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:intellprop_sp:destination:mss_objects_dicts:delete',
    ]
  end
end
