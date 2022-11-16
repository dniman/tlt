Dir[File.expand_path('../paycards/**/*.rake', __FILE__)].each {|path| import path}

namespace :paycards do
  task :import => [
    'paycards:import:tasks',
  ] 
  
  task :destroy => [
    'paycards:destroy:tasks',
  ] 
end  
