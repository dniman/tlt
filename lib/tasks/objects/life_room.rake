import 'lib/tasks/objects/life_room/import.rake'
import 'lib/tasks/objects/life_room/destroy.rake'

namespace :objects do
  namespace :life_room do

    task :import => [
      'objects:life_room:import:tasks',
    ] 
    
    task :destroy => [
      'objects:life_room:destroy:tasks',
    ] 

  end
end 
