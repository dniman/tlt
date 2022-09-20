Dir[File.expand_path('../corrs/**/*.rake', __FILE__)].each {|path| import path}

namespace :corrs do
  task :import => [
    'corrs:import:tasks',
  ] 
  
  task :destroy => [
    'corrs:destroy:tasks',
  ] 
end  

