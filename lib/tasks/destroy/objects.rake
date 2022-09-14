import 'lib/tasks/destroy/objects/land.rake'
import 'lib/tasks/destroy/objects/houses_life.rake'
import 'lib/tasks/destroy/objects/houses_unlife.rake'
import 'lib/tasks/destroy/objects/construction.rake'
import 'lib/tasks/destroy/objects/unfinished.rake'
import 'lib/tasks/destroy/objects/life_room.rake'
import 'lib/tasks/destroy/objects/unlife_room.rake'

namespace :destroy do
  namespace :objects do

  task :tasks => [
    'destroy:objects:land:tasks',
    'destroy:objects:houses_life:tasks',
    'destroy:objects:houses_unlife:tasks',
    'destroy:objects:construction:tasks',
    'destroy:objects:unfinished:tasks',
    'destroy:objects:life_room:tasks',
    'destroy:objects:unlife_room:tasks'
  ]
end
