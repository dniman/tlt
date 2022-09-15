import 'lib/tasks/destination/establish_connection.rake'
import 'lib/tasks/destination/tables_instantiate.rake'
import 'lib/tasks/destination/s_objects/completed_tasks/insert.rake'

namespace :destination do
  task :initialize => ['destination:establish_connection', 'destination:tables_instantiate!', 'destination:s_objects:completed_tasks:insert']
end
