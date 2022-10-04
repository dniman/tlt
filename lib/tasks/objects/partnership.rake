Dir[File.expand_path('../partnership/**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :partnership do

    task :import => [
      'objects:partnership:import:tasks',
    ] 
    
    task :destroy => [
      'objects:partnership:destroy:tasks',
    ] 

  end
end 
