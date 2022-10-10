Dir[File.expand_path('../storage_authority_ei/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :storage_authority_ei do
    task :import do
      Rake.invoke_task 'dictionaries:storage_authority_ei:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:storage_authority_ei:destination:mss_objects_dicts:delete',
    ]
  end
end
