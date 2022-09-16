Dir[File.expand_path('../construction/**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :construction do

    task :import => [
      'objects:construction:import:tasks',
    ] 
    
    task :destroy => [
      'objects:construction:destroy:tasks',
    ] 

  end
end  
