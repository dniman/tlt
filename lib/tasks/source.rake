import 'lib/tasks/source/establish_connection.rake'
import 'lib/tasks/source/tables_instantiate.rake'
import 'lib/tasks/source/___ids/create_table.rake'

namespace :source do
  task :initialize => [
    'source:establish_connection', 
    'source:tables_instantiate!', 
    'source:___ids:create_table',
  ]
end
