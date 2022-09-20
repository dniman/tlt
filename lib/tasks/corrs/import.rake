namespace :corrs do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'corrs:source:ids:insert'
      Rake.invoke_task 'corrs:destination:s_corr:insert'
      Rake.invoke_task 'corrs:source:ids:update_link'
    end

  end
end
