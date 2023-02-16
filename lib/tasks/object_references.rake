import 'lib/tasks/object_references/import.rake'
import 'lib/tasks/object_references/destroy.rake'

namespace :object_references do

  task :import => [
    'object_references:import',
  ] 
  
  task :destroy => [
    'object_references:destroy',
  ] 

end  

