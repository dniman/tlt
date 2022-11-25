Dir[File.expand_path('../payments/**/*.rake', __FILE__)].each {|path| import path}

namespace :payments do
  task :import => [
    'payments:import:tasks',
  ] 
  
  task :destroy => [
    'payments:destroy:tasks',
  ] 
end  
