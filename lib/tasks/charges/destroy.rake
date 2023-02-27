namespace :charges do
  namespace :destroy do

    task :tasks => [
      'charges:destination:___del_ids:insert',
      'charges:destination:t_charge_accrual:delete',
      'charges:destination:charge:delete',
      'charges:destination:rem3:delete',
      'charges:destination:rem2:delete',
      'charges:destination:rem1:delete',
      'charges:destination:entry:delete',
      'charges:destination:___del_ids:delete',
      'charges:destination:___charge_save:drop___cinc',
      'charges:destination:___charge_save:drop___corr1',
      'charges:destination:___charge_save:drop_table',
    ]

  end
end
