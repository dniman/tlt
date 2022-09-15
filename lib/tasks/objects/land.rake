import 'lib/tasks/objects/land/import.rake'
import 'lib/tasks/objects/land/destroy.rake'

namespace :objects do
  namespace :land do

    task :import => [
      'objects:land:import:tasks',
    ] 
    
    task :destroy => [
      'objects:land:destroy:tasks',
    ] 

  end
end 
