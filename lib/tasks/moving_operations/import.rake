namespace :moving_operations do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'moving_operations:source:___moving_operations:create_table', 'UNDELETABLE'
      Rake.invoke_task 'moving_operations:source:___moving_operations:insert', 'UNDELETABLE'
      Rake.invoke_task 'moving_operations:source:___ids:insert', 'UNDELETABLE'
      Rake.invoke_task 'moving_operations:source:___ids:add___code_group'
      Rake.invoke_task 'moving_operations:source:___ids:update___code_group'
      Rake.invoke_task 'moving_operations:source:___moving_operations:add___is_change_reestr'
      Rake.invoke_task 'moving_operations:source:___moving_operations:update___is_change_reestr'
      Rake.invoke_task 'moving_operations:source:___moving_operations:add___is_excl_from_r'
      Rake.invoke_task 'moving_operations:source:___moving_operations:update___is_excl_from_r'
      Rake.invoke_task 'moving_operations:source:___moving_operations:add___link_a'
      Rake.invoke_task 'moving_operations:source:___moving_operations:update___link_a'
      Rake.invoke_task 'moving_operations:source:___moving_operations:add___link_pc0'
      Rake.invoke_task 'moving_operations:source:___moving_operations:update___link_pc0'
      Rake.invoke_task 'moving_operations:destination:mss_moves_key:insert'
      Rake.invoke_task 'moving_operations:source:___moving_operations:add___link_key'
      Rake.invoke_task 'moving_operations:source:___moving_operations:update___link_key'
      Rake.invoke_task 'moving_operations:source:___moving_operations:add___link_corr'
      Rake.invoke_task 'moving_operations:source:___moving_operations:update___link_corr'
      Rake.invoke_task 'moving_operations:source:___moving_operations:update___link_corr2'
      Rake.invoke_task 'moving_operations:source:___moving_operations:add___link_cause_b'
      Rake.invoke_task 'moving_operations:source:___moving_operations:update___link_cause_b'
      Rake.invoke_task 'moving_operations:source:___moving_operations:add___link_cause_e'
      Rake.invoke_task 'moving_operations:source:___moving_operations:update___link_cause_e'
      Rake.invoke_task 'moving_operations:source:___moving_operations:update___link_cause_e2'
      Rake.invoke_task 'moving_operations:source:___moving_operations:update___link_cause_e3'
      Rake.invoke_task 'moving_operations:destination:mss_movs:insert'
      Rake.invoke_task 'moving_operations:source:___ids:update___link'
    end

  end
end
