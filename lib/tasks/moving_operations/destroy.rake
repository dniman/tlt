namespace :moving_operations do
  namespace :destroy do

    task :tasks => [
      'moving_operations:destination:mss_movs:delete',
      'moving_operations:destination:mss_moves_key:delete',

      'moving_operations:source:___moving_operations:drop___link_a',
      'moving_operations:source:___moving_operations:drop___link_pc0'
    ]

  end
end
