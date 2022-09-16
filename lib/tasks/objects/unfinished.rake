Dir[File.expand_path('../unfinished/**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :unfinished do

    task :import => [
      'objects:unfinished:import:tasks',
    ] 
    
    task :destroy => [
      'objects:unfinished:destroy:tasks',
    ] 

  end
end 
