namespace :paycardobjects do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'paycardobjects:source:___paycardobjects:create_table'
      Rake.invoke_task 'paycardobjects:source:___paycardobjects:insert'
      Rake.invoke_task 'paycardobjects:source:___ids:insert'
      Rake.invoke_task 'paycardobjects:destination:paycardobjects:insert'
      Rake.invoke_task 'paycardobjects:source:___ids:update_link'
    end

  end
end
