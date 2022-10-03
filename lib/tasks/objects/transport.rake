Dir[File.expand_path('../transport/**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :transport do

    task :import => [
      'objects:transport:import:tasks',
    ] 
    
    task :destroy => [
      'objects:transport:destroy:tasks',
    ] 

  end
end 
