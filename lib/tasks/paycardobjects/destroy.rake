namespace :paycardobjects do
  namespace :destroy do

    task :tasks => [
      'paycardobjects:destination:___del_ids:insert',
      'paycardobjects:destination:paycardobjects:delete',
      'paycardobjects:destination:___del_ids:delete',
    ]

  end
end
