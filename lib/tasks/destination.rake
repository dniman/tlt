import 'lib/tasks/destination/establish_connection.rake'
import 'lib/tasks/destination/tables_instantiate.rake'

namespace :destination do
  task :initialize => ['destination:establish_connection', 'destination:tables_instantiate!']
end
