namespace :payments do
  namespace :destroy do
    task :tasks => [
      'payments:destination:___del_ids:insert',
      'payments:destination:t_charge:delete',
      'payments:destination:extrem:delete',
      'payments:destination:rem3:delete',
      'payments:destination:rem2:delete',
      'payments:destination:t_rem1:delete',
      'payments:destination:rem1:delete',
      'payments:destination:entry:delete',
      'payments:destination:___del_ids:delete',
      'payments:source:payments:drop___row_id',
      'payments:source:payments:drop___paycard_id',
      'payments:source:payments:drop___type',
      'payments:source:payments:drop___entry',
      'payments:source:payments:drop___object',
      'payments:source:payments:drop___baccount',
      'payments:source:payments:drop___bcorr',
      'payments:source:payments:drop___income_code',
      'payments:source:payments:drop___income',
      'payments:source:payments:drop___rem1',
      'payments:source:payments:drop___rem2',
      'payments:source:payments:drop___rem3',
      'payments:source:payments:drop___extrem'
    ]

  end
end
