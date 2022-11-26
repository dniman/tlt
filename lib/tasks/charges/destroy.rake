namespace :charges do
  namespace :destroy do

    task :tasks => [
      'charges:destination:___charge_save:drop___cinc',
      'charges:destination:___charge_save:drop___corr1',
      'charges:destination:rem3:delete',
      'charges:destination:rem2_app:delete',
      'charges:destination:rem2:delete',
      'charges:destination:charge:delete',
      'charges:destination:rem1:delete',
      'charges:destination:___charge_save:drop_table',
    ]

  end
end
