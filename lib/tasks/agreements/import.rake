namespace :agreements do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'agreements:source:___agreements:create_table', 'UNDELETABLE'
      Rake.invoke_task 'agreements:source:___agreements:insert', 'UNDELETABLE'
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
      Rake.invoke_task 'agreements:source:___agreements:add___transferbasis_link'
      Rake.invoke_task 'agreements:source:___agreements:update___transferbasis_link'
      Rake.invoke_task 'agreements:source:___agreements:add___docstate_name'
      Rake.invoke_task 'agreements:source:___agreements:update___docstate_name'
      Rake.invoke_task 'agreements:source:___agreements:add___status_name'
      Rake.invoke_task 'agreements:source:___agreements:update___status_name'
      Rake.invoke_task 'agreements:source:___agreements:add___status'
      Rake.invoke_task 'agreements:source:___agreements:update___status'
      Rake.invoke_task 'agreements:source:___ids:insert'
      Rake.invoke_task 'agreements:source:___ids:add___object'
      Rake.invoke_task 'agreements:source:___ids:update___object'
      Rake.invoke_task 'agreements:source:movesets:add___client_id'
      Rake.invoke_task 'agreements:source:movesets:update___client_id'
      byebug
      Rake.invoke_task 'agreements:source:___agreements:add___client_id'
      Rake.invoke_task 'agreements:source:___agreements:update___client_id'

      Rake.invoke_task 'agreements:destination:agreement:insert'
      Rake.invoke_task 'agreements:source:___ids:update_link'
      Rake.invoke_task 'agreements:source:___ids:drop___object'

      Rake.invoke_task 'agreements:source:___agreements:drop___ground_owner_count'
      Rake.invoke_task 'agreements:source:___agreements:drop___link_type'
      Rake.invoke_task 'agreements:source:___agreements:drop___ground_owner'
      #Rake.invoke_task 'agreements:source:___agreements:drop___transferbasis_name'
      #Rake.invoke_task 'agreements:source:___agreements:drop___transferbasis_link'
      #Rake.invoke_task 'agreements:source:___agreements:drop___docset_name'
      #Rake.invoke_task 'agreements:source:___agreements:drop___docset_link'

      #Rake.invoke_task 'agreements:source:movesets:drop___agreement_id'
      Rake.invoke_task 'agreements:source:movesets:drop___ground_owner'
      #Rake.invoke_task 'agreements:source:movesets:drop___client_id'
      #Rake.invoke_task 'agreements:source:___agreements:drop___client_id'

      # Архивный, прекращен
      Rake.invoke_task 'agreements:destination:agreement_sign:arh_final:insert'
      # АРХИВ ПК "Земля"
      Rake.invoke_task 'agreements:destination:agreement_sign:arh_pk_zemlya:insert'
      # Закрытый проект
      Rake.invoke_task 'agreements:destination:agreement_sign:closed_project:insert'
      # действующий
      Rake.invoke_task 'agreements:destination:agreement_sign:current:insert'
      # прекращен
      Rake.invoke_task 'agreements:destination:agreement_sign:discontinued:insert'
      # Прекращен, но земельный участок не возвращен
      Rake.invoke_task 'agreements:destination:agreement_sign:discontinued_oops_zu:insert'
      # Прекращен, но участок не м.б. истребован
      Rake.invoke_task 'agreements:destination:agreement_sign:discontinued_oops_zu1:insert'
      # проект
      Rake.invoke_task 'agreements:destination:agreement_sign:project:insert'
      # расторгнут
      Rake.invoke_task 'agreements:destination:agreement_sign:terminated:insert'
      
      # Документы
      Rake.invoke_task 'agreements:source:___ids:add___link_list'
      Rake.invoke_task 'agreements:source:___ids:update___link_list'
      Rake.invoke_task 'agreements:destination:mss_detail_list:insert'
      Rake.invoke_task 'agreements:source:___ids:drop___link_list'
    end

  end
end
