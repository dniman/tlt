namespace :paycards do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'paycards:source:___paycards:create_table', 'UNDELETABLE'
      Rake.invoke_task 'paycards:source:___paycards:insert1', 'UNDELETABLE'
      Rake.invoke_task 'paycards:source:___paycards:insert2', 'UNDELETABLE'
      Rake.invoke_task 'paycards:source:___ids:insert1', 'UNDELETABLE'
      Rake.invoke_task 'paycards:source:___ids:insert2', 'UNDELETABLE'
      
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
      Rake.invoke_task 'paycards:source:___paycards:add___account'
      Rake.invoke_task 'paycards:source:___paycards:update___account'
      Rake.invoke_task 'paycards:source:___paycards:add___status'
      Rake.invoke_task 'paycards:source:___paycards:update___status'
      Rake.invoke_task 'paycards:source:___paycards:update_su_d'
      Rake.invoke_task 'paycards:source:___paycards:update_de_d'
      
      Rake.invoke_task 'paycards:destination:paycard:insert1'
      Rake.invoke_task 'paycards:source:___ids:update_link1'
      Rake.invoke_task 'paycards:source:___paycards:add___link_up'
      Rake.invoke_task 'paycards:source:___paycards:update___link_up'
      
      Rake.invoke_task 'paycards:destination:paycard:insert2'
      Rake.invoke_task 'paycards:source:___ids:update_link2'
      
      Rake.invoke_task 'paycards:destination:paycard_sign:exit_da:insert'
      Rake.invoke_task 'paycards:destination:paycard_sign:plurality_persons:insert'
      Rake.invoke_task 'paycards:destination:paycard_sign:stage_reg:insert'
      
      # Документы
      Rake.invoke_task 'paycards:source:___ids:add___link_list'
      Rake.invoke_task 'paycards:source:___ids:update___link_list'
      Rake.invoke_task 'paycards:destination:mss_detail_list:insert'
      Rake.invoke_task 'paycards:source:___ids:drop___link_list'
    end

  end
end
