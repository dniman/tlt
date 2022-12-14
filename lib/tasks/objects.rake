import 'lib/tasks/objects/land.rake'
import 'lib/tasks/objects/houses_life.rake'
import 'lib/tasks/objects/houses_unlife.rake'
import 'lib/tasks/objects/construction.rake'
import 'lib/tasks/objects/engineering_network.rake'
import 'lib/tasks/objects/automobile_road.rake'
import 'lib/tasks/objects/unfinished.rake'
import 'lib/tasks/objects/life_room.rake'
import 'lib/tasks/objects/unlife_room.rake'
import 'lib/tasks/objects/movable_other.rake'
import 'lib/tasks/objects/transport.rake'
import 'lib/tasks/objects/share.rake'
import 'lib/tasks/objects/partnership.rake'
import 'lib/tasks/objects/exright_intellprop.rake'

namespace :objects do

  task :import => [
    'objects:land:import',
    'objects:houses_life:import',
    'objects:houses_unlife:import',
    'objects:construction:import',
    'objects:engineering_network:import',
    'objects:automobile_road:import',
    'objects:unfinished:import',
    'objects:life_room:import',
    'objects:unlife_room:import',
    'objects:movable_other:import',
    'objects:transport:import',
    'objects:share:import',
    'objects:partnership:import',
    'objects:exright_intellprop:import',
  ] 
  
  task :destroy => [
    'objects:houses_life:destroy',
    'objects:houses_unlife:destroy',
    'objects:construction:destroy',
    'objects:engineering_network:destroy',
    'objects:automobile_road:destroy',
    'objects:unfinished:destroy',
    'objects:life_room:destroy',
    'objects:unlife_room:destroy',
    'objects:land:destroy',
    'objects:movable_other:destroy',
    'objects:transport:destroy',
    'objects:share:destroy',
    'objects:partnership:destroy',
    'objects:exright_intellprop:destroy',
  ] 

end  

