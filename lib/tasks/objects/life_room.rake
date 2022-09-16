Dir[File.expand_path('../life_room/**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :life_room do

    task :import => [
      'objects:life_room:import:tasks',
    ] 
    
    task :destroy => [
      'objects:life_room:destroy:tasks',
    ] 

  end
end 
