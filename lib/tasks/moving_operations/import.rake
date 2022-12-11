namespace :moving_operations do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'moving_operations:source:___moving_operations:create_table'
      Rake.invoke_task 'moving_operations:source:___moving_operations:insert'
      Rake.invoke_task 'moving_operations:source:___ids:insert'
      Rake.invoke_task 'moving_operations:source:___moving_operations:add___link_a'
      Rake.invoke_task 'moving_operations:source:___moving_operations:update___link_a'
      Rake.invoke_task 'moving_operations:source:___moving_operations:add___link_pc0'
      Rake.invoke_task 'moving_operations:source:___moving_operations:update___link_pc0'
      Rake.invoke_task 'moving_operations:destination:mss_moves_key:insert'
    end

  end
end
