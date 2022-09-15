import 'lib/tasks/objects/unlife_room/import.rake'
import 'lib/tasks/objects/unlife_room/destroy.rake'

namespace :objects do
  namespace :unlife_room do

    task :import => [
      'objects:unlife_room:import:tasks',
    ] 
    
    task :destroy => [
      'objects:unlife_room:destroy:tasks',
    ] 

  end
end 
