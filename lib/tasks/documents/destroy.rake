namespace :documents do
  namespace :destroy do

    task :tasks => [
      'documents:destination:mss_docs:delete',
      'documents:destination:mss_docs:drop___type',
    ]

  end
end
