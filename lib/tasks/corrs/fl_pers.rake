Dir[File.expand_path('../fl_pers/**/*.rake', __FILE__)].each {|path| import path}

namespace :corrs do
  namespace :fl_pers do

    task :import => [
      'corrs:fl_pers:import:tasks',
    ] 
    
    task :destroy => [
      'corrs:fl_pers:destroy:tasks',
    ] 

  end
end 
