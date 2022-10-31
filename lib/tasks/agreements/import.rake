namespace :agreements do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'agreements:source:___agreements:create_table'
      Rake.invoke_task 'agreements:source:___agreements:insert'
      Rake.invoke_task 'agreements:source:movesets:add___agreement_id'
      Rake.invoke_task 'agreements:source:movesets:update___agreement_id'
      Rake.invoke_task 'agreements:source:movesets:add___ground_owner'
      Rake.invoke_task 'agreements:source:movesets:update___ground_owner'
      #Rake.invoke_task 'agreements:source:ids:insert'
      

      Rake.invoke_task 'agreements:source:movesets:drop___agreement_id'
      Rake.invoke_task 'agreements:source:movesets:drop___ground_owner'
    end

  end
end
