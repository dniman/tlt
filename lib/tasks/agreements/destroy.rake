namespace :agreements do
  namespace :destroy do

    task :tasks => [
      'agreements:source:movesets:drop___agreement_id',
      'agreements:source:movesets:drop___ground_owner',
      'agreements:source:___agreements:drop___ground_owner_count',
      'agreements:source:___agreements:drop___link_type',
      'agreements:source:___agreements:drop___ground_owner',
      'agreements:source:___agreements:drop___transferbasis_name',
    ]

  end
end