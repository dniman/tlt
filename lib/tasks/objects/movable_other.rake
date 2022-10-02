Dir[File.expand_path('../movable_other/**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :movable_other do

    task :import => [
      'objects:movable_other:import:tasks',
    ] 
    
    task :destroy => [
      'objects:movable_other:destroy:tasks',
    ] 

  end
end 
