import 'lib/tasks/import/objects/land.rake'
import 'lib/tasks/import/objects/houses_life.rake'
import 'lib/tasks/import/objects/houses_unlife.rake'
import 'lib/tasks/import/objects/construction.rake'
import 'lib/tasks/import/objects/unfinished.rake'
import 'lib/tasks/import/objects/life_room.rake'
import 'lib/tasks/import/objects/unlife_room.rake'

namespace :import do
  namespace :objects do

    task :tasks => [
      'import:objects:land:tasks',
      'import:objects:houses_life:tasks',
      'import:objects:houses_unlife:tasks',
      'import:objects:construction:tasks',
      'import:objects:unfinished:tasks',
      'import:objects:life_room:tasks',
      'import:objects:unlife_room:tasks'
    ] 

  end  
end

