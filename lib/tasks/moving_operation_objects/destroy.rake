namespace :moving_operation_objects do
  namespace :destroy do

    task :tasks => [
      'moving_operation_objects:destination:___del_ids:insert',
      'moving_operation_objects:destination:mss_moves_mss_objects:delete',
      'moving_operation_objects:destination:___del_ids:delete',

      'moving_operation_objects:source:___moving_operation_objects:drop___code_group',
      'moving_operation_objects:source:___moving_operation_objects:drop___is_change_reestr',
      'moving_operation_objects:source:___moving_operation_objects:drop___is_excl_from_r',
      'moving_operation_objects:source:___moving_operation_objects:drop___object_type_name',
      'moving_operation_objects:source:___moving_operation_objects:drop___link_rp',
    ]

  end
end
