Dir[File.expand_path('../func_nazn_ei/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :func_nazn_ei do
    task :import do
      Rake.invoke_task 'dictionaries:func_nazn_ei:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:func_nazn_ei:destination:mss_objects_dicts:delete',
    ]
  end
end
