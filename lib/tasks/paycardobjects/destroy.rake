namespace :paycardobjects do
  namespace :destroy do

    task :tasks => [
      'paycardobjects:destination:paycardobjects:delete',
    ]

  end
end
