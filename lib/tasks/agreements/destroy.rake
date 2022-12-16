namespace :agreements do
  namespace :destroy do

    task :tasks => [
      'agreements:destination:___del_ids:insert',
      'agreements:destination:mss_detail_list:delete',
      'agreements:destination:agreement_sign:arh_final:delete',
      'agreements:destination:agreement_sign:arh_pk_zemlya:delete',
      'agreements:destination:agreement_sign:closed_project:delete',
      'agreements:destination:agreement_sign:current:delete',
      'agreements:destination:agreement_sign:discontinued:delete',
      'agreements:destination:agreement_sign:discontinued_oops_zu:delete',
      'agreements:destination:agreement_sign:discontinued_oops_zu1:delete',
      'agreements:destination:agreement_sign:project:delete',
      'agreements:destination:agreement_sign:terminated:delete',

      'agreements:destination:agreement:delete',
      'agreements:destination:___del_ids:delete',

      'agreements:source:movesets:drop___agreement_id',
      'agreements:source:movesets:drop___ground_owner',
      'agreements:source:movesets:drop___client_id',
      'agreements:source:___agreements:drop___ground_owner_count',
      'agreements:source:___agreements:drop___link_type',
      'agreements:source:___agreements:drop___ground_owner',
      'agreements:source:___agreements:drop___transferbasis_name',
      'agreements:source:___agreements:drop___transferbasis_link',
      'agreements:source:___agreements:drop___docstate_name',
      'agreements:source:___agreements:drop___status_name',
      'agreements:source:___agreements:drop___status',
      'agreements:source:___agreements:drop___client_id',
      'agreements:source:___ids:drop___object',
      'agreements:source:___ids:drop___link_list',
    ]

  end
end
