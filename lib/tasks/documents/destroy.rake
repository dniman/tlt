namespace :documents do
  namespace :destroy do

    task :tasks => [
      'documents:destination:___del_ids:insert',
      'documents:destination:mss_docs:delete',
      'documents:destination:___del_ids:delete',
      'documents:destination:mss_docs:drop___type',
    ]

  end
end
