Dir[File.expand_path('../paycardobjects/**/*.rake', __FILE__)].each {|path| import path}

namespace :paycardobjects do
  task :import => [
    'paycardobjects:import:tasks',
  ] 
  
  task :destroy => [
    'paycardobjects:destroy:tasks',
  ] 
end  
