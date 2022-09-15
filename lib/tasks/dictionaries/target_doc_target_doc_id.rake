Dir[File.expand_path('../target_doc_target_doc_id/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :target_doc_target_doc_id do
    task :import do
      Rake.invoke_task 'dictionaries:target_doc_target_doc_id:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:target_doc_target_doc_id:destination:mss_objects_dicts:delete',
    ]
  end
end
