import 'lib/tasks/objects/houses_life/import.rake'
import 'lib/tasks/objects/houses_life/destroy.rake'

namespace :objects do
  namespace :houses_life do

    task :import => [
      'objects:houses_life:import:tasks',
    ] 
    
    task :destroy => [
      'objects:houses_life:destroy:tasks',
    ] 

  end
end 
