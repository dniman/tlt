namespace :agreements do
  namespace :destroy do

    task :tasks => [
      'agreements:destination:___del_ids:insert',
      'agreements:destination:agreement_sign:arh_final:insert',
      'agreements:destination:agreement_sign:arh_pk_zemlya:insert',
      'agreements:destination:agreement_sign:closed_project:insert',
      'agreements:destination:agreement_sign:current:insert',
      'agreements:destination:agreement_sign:discontinued:insert',
      'agreements:destination:agreement_sign:discontinued_oops_zu:insert',
      'agreements:destination:agreement_sign:discontinued_oops_zu1:insert',
      'agreements:destination:agreement_sign:project:insert',
      'agreements:destination:agreement_sign:terminated:insert',

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
    ]

  end
end
