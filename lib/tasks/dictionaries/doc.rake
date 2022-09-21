Dir[File.expand_path('../doc/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :doc do
    task :import do
      Rake.invoke_task 'dictionaries:doc:destination:mss_objcorr_types:insert'
    end 
    
    task :destroy => [
      'dictionaries:doc:destination:mss_objcorr_types:delete',
    ]
  end
end
