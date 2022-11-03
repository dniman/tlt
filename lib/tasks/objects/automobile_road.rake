Dir[File.expand_path('../automobile_road/**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :automobile_road do

    task :import => [
      'objects:automobile_road:import:tasks',
    ] 
    
    task :destroy => [
      'objects:automobile_road:destroy:tasks',
    ] 

  end
end  
