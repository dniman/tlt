Dir[File.expand_path('../houses_unlife/**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :houses_unlife do

    task :import => [
      'objects:houses_unlife:import:tasks',
    ] 
    
    task :destroy => [
      'objects:houses_unlife:destroy:tasks',
    ] 

  end
end 
