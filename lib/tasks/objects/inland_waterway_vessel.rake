Dir[File.expand_path('../inland_waterway_vessel/**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :inland_waterway_vessel do

    task :import => [
      'objects:inland_waterway_vessel:import:tasks',
    ] 
    
    task :destroy => [
      'objects:inland_waterway_vessel:destroy:tasks',
    ] 

  end
end 
