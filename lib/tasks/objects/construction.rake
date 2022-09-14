import 'lib/tasks/objects/construction/import.rake'
import 'lib/tasks/objects/construction/destroy.rake'

namespace :objects do
  namespace :construction do

    task :import => [
      'objects:construction:import:tasks',
    ] 
    
    task :destroy => [
      'objects:construction:destroy:tasks',
    ] 

  end
end  
