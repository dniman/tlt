Dir[File.expand_path('../moving_operation_objects/**/*.rake', __FILE__)].each {|path| import path}

namespace :moving_operation_objects do
  task :import => [
    'moving_operation_objects:import:tasks',
  ] 
  
  task :destroy => [
    'moving_operation_objects:destroy:tasks',
  ] 
end  
