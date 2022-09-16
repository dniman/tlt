Dir[File.expand_path('../land/**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :land do

    task :import => [
      'objects:land:import:tasks',
    ] 
    
    task :destroy => [
      'objects:land:destroy:tasks',
    ] 

  end
end 
