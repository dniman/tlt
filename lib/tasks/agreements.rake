Dir[File.expand_path('../agreements/**/*.rake', __FILE__)].each {|path| import path}

namespace :agreements do
  task :import => [
    'agreements:import:tasks',
  ] 
  
  task :destroy => [
    'agreements:destroy:tasks',
  ] 
end  
