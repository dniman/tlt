import 'lib/tasks/objects/houses_unlife/import.rake'
import 'lib/tasks/objects/houses_unlife/destroy.rake'

namespace :objects do
  namespace :houses_unlife do

    task :import => [
      'objects:houses_unlife:import:tasks',
    ] 
    
    task :destroy => [
      'objects:houses_unlife:destroy:tasks',
    ] 

  end
end 
