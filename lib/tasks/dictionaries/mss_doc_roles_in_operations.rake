Dir[File.expand_path('../mss_docs_roles_in_operations/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :mss_doc_roles_in_operations do
    task :import do
      Rake.invoke_task 'dictionaries:mss_docs_roles_in_operations:source:___ids:insert', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:mss_docs_roles_in_operations:destination:mss_docs_roles_in_operations:insert'
      Rake.invoke_task 'dictionaries:mss_docs_roles_in_operations:source:___ids:update_link'
    end 
    
    task :destroy => [
      'dictionaries:mss_docs_roles_in_operations:destination:___del_ids:insert',
      'dictionaries:mss_docs_roles_in_operations:destination:mss_docs_roles_in_operations:delete',
      'dictionaries:mss_docs_roles_in_operations:destination:___del_ids:delete'
    ]
  end
end
