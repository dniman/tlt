Dir[File.expand_path('../moving_operations/**/*.rake', __FILE__)].each {|path| import path}

namespace :moving_operations do
  task :import => [
    'moving_operations:import:tasks',
  ] 
  
  task :destroy => [
    'moving_operations:destroy:tasks',
  ] 
end  
