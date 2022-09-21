namespace :corrs do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'corrs:source:ids:insert'
      Rake.invoke_task 'corrs:destination:s_corr:insert'
      Rake.invoke_task 'corrs:source:ids:update_link'
      Rake.invoke_task 'corrs:destination:t_corr_dict:reference_corr_type:insert'
    end

  end
end