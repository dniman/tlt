namespace :agreements do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'agreements:source:___agreements:create_table'
      Rake.invoke_task 'agreements:source:___agreements:insert'
    end

  end
end
