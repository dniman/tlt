namespace :moving_operation_objects do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'moving_operation_objects:source:___moving_operation_objects:create_table', 'UNDELETABLE'
      Rake.invoke_task 'moving_operation_objects:source:___moving_operation_objects:insert', 'UNDELETABLE'
      Rake.invoke_task 'moving_operation_objects:source:___moving_operation_objects:add___object_type_name'
      Rake.invoke_task 'moving_operation_objects:source:___moving_operation_objects:update___object_type_name'
      Rake.invoke_task 'moving_operation_objects:source:___ids:insert', 'UNDELETABLE'
      Rake.invoke_task 'moving_operation_objects:source:___moving_operation_objects:add___code_group'
      Rake.invoke_task 'moving_operation_objects:source:___moving_operation_objects:update___code_group'
      Rake.invoke_task 'moving_operation_objects:source:___moving_operation_objects:add___is_change_reestr'
      Rake.invoke_task 'moving_operation_objects:source:___moving_operation_objects:update___is_change_reestr'
      Rake.invoke_task 'moving_operation_objects:source:___moving_operation_objects:add___is_excl_from_r'
      Rake.invoke_task 'moving_operation_objects:source:___moving_operation_objects:update___is_excl_from_r'
      Rake.invoke_task 'moving_operation_objects:source:___moving_operation_objects:add___link_rp'
      Rake.invoke_task 'moving_operation_objects:source:___moving_operation_objects:update___link_rp'
      Rake.invoke_task 'moving_operation_objects:destination:mss_moves_mss_objects:insert'
    end

  end
end
