namespace :paycards do
  namespace :destroy do

    task :tasks => [
      'paycards:destination:___del_ids:insert',

      'paycards:destination:mss_detail_list:delete',

      'paycards:destination:paycard_sign:exit_da:delete',
      'paycards:destination:paycard_sign:plurality_persons:delete',
      'paycards:destination:paycard_sign:stage_reg:delete',
      
      'paycards:destination:paycard:admin_fk_disable',
      'paycards:destination:paycard:delete2',
      'paycards:destination:paycard:delete1',
      'paycards:destination:paycard:admin_fk_enable',
      'paycards:destination:___del_ids:delete',

      'paycards:source:___paycards:drop___link_up',
      'paycards:source:___paycards:drop___link_a',
      'paycards:source:___paycards:drop___link_type_a',
      'paycards:source:___paycards:drop___name_type_a',
      'paycards:source:___paycards:drop___name_objtype',
      'paycards:source:___paycards:drop___payer_type',
      'paycards:source:___paycards:drop___corr1',
      'paycards:source:___paycards:drop___corr2',
      'paycards:source:___paycards:drop___inc_a',
      'paycards:source:___paycards:drop___inc_p',
      'paycards:source:___paycards:drop___inc_pr',
      'paycards:source:___paycards:drop___sum_rtype',
      'paycards:source:___paycards:drop___account',
      'paycards:source:___paycards:drop___status',
      'paycards:source:___ids:drop___link_list',
    ]

  end
end
