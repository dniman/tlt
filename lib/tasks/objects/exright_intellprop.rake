Dir[File.expand_path('../exright_intellprop/**/*.rake', __FILE__)].each {|path| import path}

namespace :objects do
  namespace :transport do

    task :import => [
      'objects:exright_intellprop:import:tasks',
    ] 
    
    task :destroy => [
      'objects:exright_intellprop:destroy:tasks',
    ] 

  end
end 
