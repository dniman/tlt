namespace :object_references do
  namespace :destroy do
    task :tasks => [
      'object_references:destination:___del_ids:insert',
      
      # Составные части объектов
      'object_references:destination:mss_objects_struelem:delete',

      'object_references:destination:___del_ids:delete',
    ]
  end
end
