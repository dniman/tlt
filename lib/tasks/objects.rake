import 'lib/tasks/objects/land.rake'
import 'lib/tasks/objects/houses_life.rake'
import 'lib/tasks/objects/houses_unlife.rake'
import 'lib/tasks/objects/construction.rake'
import 'lib/tasks/objects/unfinished.rake'
import 'lib/tasks/objects/life_room.rake'
import 'lib/tasks/objects/unlife_room.rake'

namespace :objects do

  task :import => [
    'objects:land:import',
    'objects:houses_life:import',
    'objects:houses_unlife:import',
    'objects:construction:import',
    'objects:unfinished:import',
    'objects:life_room:import',
    'objects:unlife_room:import'
  ] 
  
  task :destroy => [
    'objects:land:destroy',
    'objects:houses_life:destroy',
    'objects:houses_unlife:destroy',
    'objects:construction:destroy',
    'objects:unfinished:destroy',
    'objects:life_room:destroy',
    'objects:unlife_room:destroy'
  ] 

end  

