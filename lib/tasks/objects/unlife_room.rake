Dir[File.expand_path('../unlife_room/**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :unlife_room do

    task :import => [
      'objects:unlife_room:import:tasks',
    ] 
    
    task :destroy => [
      'objects:unlife_room:destroy:tasks',
    ] 

  end
end 
