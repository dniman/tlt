namespace :paycardobjects do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'paycardobjects:source:___paycardobjects:create_table', 'UNDELETABLE'
      Rake.invoke_task 'paycardobjects:source:___paycardobjects:insert', 'UNDELETABLE'
      Rake.invoke_task 'paycardobjects:source:___ids:insert', 'UNDELETABLE'
      Rake.invoke_task 'paycardobjects:destination:paycardobjects:insert'
      Rake.invoke_task 'paycardobjects:source:___ids:update_link'
    end

  end
end
