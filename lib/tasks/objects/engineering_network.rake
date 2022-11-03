Dir[File.expand_path('../engineering_network/**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :engineering_network do

    task :import => [
      'objects:engineering_network:import:tasks',
    ] 
    
    task :destroy => [
      'objects:engineering_network:destroy:tasks',
    ] 

  end
end  
