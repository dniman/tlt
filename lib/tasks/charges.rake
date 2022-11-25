Dir[File.expand_path('../charges/**/*.rake', __FILE__)].each {|path| import path}

namespace :charges do
  task :import => [
    'charges:import:tasks',
  ] 
  
  task :destroy => [
    'charges:destroy:tasks',
  ] 
end  
