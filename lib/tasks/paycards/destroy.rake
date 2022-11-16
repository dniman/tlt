namespace :paycards do
  namespace :destroy do

    task :tasks => [
      'paycards:destination:paycard:delete1',
      'paycards:destination:paycard:delete2',
#
#      'agreements:source:movesets:drop___agreement_id',
#      'agreements:source:movesets:drop___ground_owner',
#      'agreements:source:movesets:drop___client_id',
#      'agreements:source:___agreements:drop___ground_owner_count',
#      'agreements:source:___agreements:drop___link_type',
#      'agreements:source:___agreements:drop___ground_owner',
#      'agreements:source:___agreements:drop___transferbasis_name',
#      'agreements:source:___agreements:drop___transferbasis_link',
#      'agreements:source:___agreements:drop___docstate_name',
#      'agreements:source:___agreements:drop___docstate_link',
#      'agreements:source:___agreements:drop___client_id',
#      'agreements:source:___ids:drop___object',
    ]

  end
end
