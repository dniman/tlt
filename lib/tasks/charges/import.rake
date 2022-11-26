namespace :charges do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'charges:source:___ids:insert'
      Rake.invoke_task 'charges:destination:___charge_save:create_table'
      Rake.invoke_task 'charges:destination:___charge_save:add___cinc'
      Rake.invoke_task 'charges:destination:___charge_save:add___corr1'
      Rake.invoke_task 'charges:destination:___charge_save:insert'
      Rake.invoke_task 'charges:destination:___charge_save:update_inc'
      Rake.invoke_task 'charges:destination:___charge_save:update_imns'
      Rake.invoke_task 'charges:destination:___charge_save:update_ccorr1'
      Rake.invoke_task 'charges:destination:___charge_save:update_corr_n1'
      Rake.invoke_task 'charges:destination:rem1:disable_trigger_rem1_insert_entry'
      Rake.invoke_task 'charges:destination:charge:insert'
      Rake.invoke_task 'charges:source:___ids:update_link'
      Rake.invoke_task 'charges:destination:___charge_save:drop_table'
      Rake.invoke_task 'charges:destination:rem1:enable_trigger_rem1_insert_entry'
    end

  end
end
