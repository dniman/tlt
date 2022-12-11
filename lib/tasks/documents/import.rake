namespace :documents do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'documents:source:___ids:insert', 'UNDELETABLE'
      Rake.invoke_task 'documents:destination:mss_docs:add___type'
      Rake.invoke_task 'documents:destination:mss_docs:insert'
      Rake.invoke_task 'documents:source:___ids:update_link'
      Rake.invoke_task 'documents:destination:mss_docs:update_link_type'
      Rake.invoke_task 'documents:destination:mss_docs:drop___type'
    end

  end
end
