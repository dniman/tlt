import 'lib/tasks/objects/unfinished/import.rake'
import 'lib/tasks/objects/unfinished/destroy.rake'

namespace :objects do
  namespace :unfinished do

    task :import => [
      'objects:unfinished:import:tasks',
    ] 
    
    task :destroy => [
      'objects:unfinished:destroy:tasks',
    ] 

  end
end 
