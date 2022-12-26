Dir[File.expand_path('../ul/**/*.rake', __FILE__)].each {|path| import path}

namespace :corrs do
  namespace :ul do

    task :import => [
      'corrs:ul:import:tasks',
    ] 
    
    task :destroy => [
      'corrs:ul:destroy:tasks',
    ] 

  end
end 
