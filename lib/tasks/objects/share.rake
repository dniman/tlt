Dir[File.expand_path('../share/**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :share do

    task :import => [
      'objects:share:import:tasks',
    ] 
    
    task :destroy => [
      'objects:share:destroy:tasks',
    ] 

  end
end 
