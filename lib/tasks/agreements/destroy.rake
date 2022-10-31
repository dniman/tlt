namespace :agreements do
  namespace :destroy do

    task :tasks => [
      'agreements:source:movesets:drop___agreement_id',
      'agreements:source:movesets:drop___ground_owner',
    ]

  end
end
