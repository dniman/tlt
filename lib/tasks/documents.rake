Dir[File.expand_path('../documents/**/*.rake', __FILE__)].each {|path| import path}

namespace :documents do
  task :import => [
    'documents:import:tasks',
  ] 
  
  task :destroy => [
    'documents:destroy:tasks',
  ] 
end  

