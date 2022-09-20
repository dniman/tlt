namespace :corrs do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'corrs:source:ids:insert'
    end

  end
end
