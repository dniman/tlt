namespace :paycards do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'paycards:source:___paycards:create_table'
      Rake.invoke_task 'paycards:source:___paycards:insert'
      Rake.invoke_task 'paycards:source:___ids:insert1'
      Rake.invoke_task 'paycards:source:___ids:insert2'
      
      Rake.invoke_task 'paycards:source:___paycards:add___link_a'
      Rake.invoke_task 'paycards:source:___paycards:update___link_a'
      Rake.invoke_task 'paycards:source:___paycards:add___link_type_a'
      Rake.invoke_task 'paycards:source:___paycards:update___link_type_a'
      Rake.invoke_task 'paycards:source:___paycards:add___name_type_a'
      Rake.invoke_task 'paycards:source:___paycards:update___name_type_a'
      Rake.invoke_task 'paycards:source:___paycards:add___corr1'
      Rake.invoke_task 'paycards:source:___paycards:update___corr1'
      Rake.invoke_task 'paycards:source:___paycards:add___payer_type'
      Rake.invoke_task 'paycards:source:___paycards:update___payer_type'
      Rake.invoke_task 'paycards:source:___paycards:add___corr2'
      Rake.invoke_task 'paycards:source:___paycards:update___corr2'
      
      Rake.invoke_task 'paycards:source:___paycards:update_cinc_a'
      Rake.invoke_task 'paycards:source:___paycards:update_cinc_p'
      Rake.invoke_task 'paycards:source:___paycards:update_cinc_pr'
      Rake.invoke_task 'paycards:source:___paycards:add___inc_a'
      Rake.invoke_task 'paycards:source:___paycards:update___inc_a'
      Rake.invoke_task 'paycards:source:___paycards:add___inc_p'
      Rake.invoke_task 'paycards:source:___paycards:update___inc_p'
      Rake.invoke_task 'paycards:source:___paycards:add___inc_pr'
      Rake.invoke_task 'paycards:source:___paycards:update___inc_pr'
      Rake.invoke_task 'paycards:source:___paycards:add___sum_rtype'
      Rake.invoke_task 'paycards:source:___paycards:update___sum_rtype'
      
      Rake.invoke_task 'paycards:destination:paycard:insert1'
      Rake.invoke_task 'paycards:source:___ids:update_link1'
      Rake.invoke_task 'paycards:source:___paycards:add___link_up'
      Rake.invoke_task 'paycards:source:___paycards:update___link_up'
      
      Rake.invoke_task 'paycards:destination:paycard:insert2'
      Rake.invoke_task 'paycards:source:___ids:update_link2'

#      Rake.invoke_task 'agreements:source:movesets:add___agreement_id'
#      Rake.invoke_task 'agreements:source:movesets:update___agreement_id'
#      Rake.invoke_task 'agreements:source:movesets:add___ground_owner'
#      Rake.invoke_task 'agreements:source:movesets:update___ground_owner'
#      Rake.invoke_task 'agreements:source:___agreements:add___ground_owner_count'
#      Rake.invoke_task 'agreements:source:___agreements:update___ground_owner_count'
#      Rake.invoke_task 'agreements:source:___agreements:add___link_type'
#      Rake.invoke_task 'agreements:source:___agreements:update___link_type'
#      Rake.invoke_task 'agreements:source:___agreements:add___ground_owner'
#      Rake.invoke_task 'agreements:source:___agreements:update___ground_owner'
#      Rake.invoke_task 'agreements:source:___agreements:add___transferbasis_name'
#      Rake.invoke_task 'agreements:source:___agreements:update___transferbasis_name'
#      Rake.invoke_task 'agreements:source:___agreements:add___transferbasis_link'
#      Rake.invoke_task 'agreements:source:___agreements:update___transferbasis_link'
#      Rake.invoke_task 'agreements:source:___agreements:add___docstate_name'
#      Rake.invoke_task 'agreements:source:___agreements:update___docstate_name'
#      Rake.invoke_task 'agreements:source:___agreements:add___docstate_link'
#      Rake.invoke_task 'agreements:source:___agreements:update___docstate_link'
#      Rake.invoke_task 'agreements:source:___ids:add___object'
#      Rake.invoke_task 'agreements:source:movesets:add___client_id'
#      Rake.invoke_task 'agreements:source:movesets:update___client_id'
#      Rake.invoke_task 'agreements:source:___agreements:add___client_id'
#      Rake.invoke_task 'agreements:source:___agreements:update___client_id'
#
#      Rake.invoke_task 'agreements:source:___ids:drop___object'
#
#      Rake.invoke_task 'agreements:source:___agreements:drop___ground_owner_count'
#      Rake.invoke_task 'agreements:source:___agreements:drop___link_type'
#      Rake.invoke_task 'agreements:source:___agreements:drop___ground_owner'
#      #Rake.invoke_task 'agreements:source:___agreements:drop___transferbasis_name'
#      #Rake.invoke_task 'agreements:source:___agreements:drop___transferbasis_link'
#      #Rake.invoke_task 'agreements:source:___agreements:drop___docset_name'
#      #Rake.invoke_task 'agreements:source:___agreements:drop___docset_link'
#
#      #Rake.invoke_task 'agreements:source:movesets:drop___agreement_id'
#      Rake.invoke_task 'agreements:source:movesets:drop___ground_owner'
#      #Rake.invoke_task 'agreements:source:movesets:drop___client_id'
#      #Rake.invoke_task 'agreements:source:___agreements:drop___client_id'
    end

  end
end
