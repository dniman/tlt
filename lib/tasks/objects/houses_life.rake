Dir[File.expand_path('../houses_life/**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :houses_life do

    task :import => [
      'objects:houses_life:import:tasks',
    ] 
    
    task :destroy => [
      'objects:houses_life:destroy:tasks',
    ] 

  end
end 
