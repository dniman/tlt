import 'lib/tasks/corrs/fl_pers.rake'
import 'lib/tasks/corrs/ul.rake'

namespace :corrs do

  task :import => [
    'corrs:fl_pers:import',
    'corrs:ul:import',
  ] 
  
  task :destroy => [
    'corrs:fl_pers:destroy',
    'corrs:ul:destroy',
  ] 

end  


