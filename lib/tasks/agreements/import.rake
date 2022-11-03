namespace :agreements do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'agreements:source:___agreements:create_table'
      Rake.invoke_task 'agreements:source:___agreements:insert'
      Rake.invoke_task 'agreements:source:movesets:add___agreement_id'
      Rake.invoke_task 'agreements:source:movesets:update___agreement_id'
      Rake.invoke_task 'agreements:source:movesets:add___ground_owner'
      Rake.invoke_task 'agreements:source:movesets:update___ground_owner'
      Rake.invoke_task 'agreements:source:___agreements:add___ground_owner_count'
      Rake.invoke_task 'agreements:source:___agreements:update___ground_owner_count'
      Rake.invoke_task 'agreements:source:___agreements:add___link_type'
      Rake.invoke_task 'agreements:source:___agreements:update___link_type'
      Rake.invoke_task 'agreements:source:___agreements:add___ground_owner'
      Rake.invoke_task 'agreements:source:___agreements:update___ground_owner'
      Rake.invoke_task 'agreements:source:___agreements:add___transferbasis_name'
      Rake.invoke_task 'agreements:source:___agreements:update___transferbasis_name'
      Rake.invoke_task 'agreements:source:___ids:insert'
      

      #Rake.invoke_task 'agreements:source:movesets:drop___agreement_id'
      #Rake.invoke_task 'agreements:source:movesets:drop___ground_owner'
      #Rake.invoke_task 'agreements:source:___agreements:drop___ground_owner_count'
      #Rake.invoke_task 'agreements:source:___agreements:drop___link_type'
      #Rake.invoke_task 'agreements:source:___agreements:drop___ground_owner'
      #Rake.invoke_task 'agreements:source:___agreements:drop___transferbasis_name'
    end

  end
end
