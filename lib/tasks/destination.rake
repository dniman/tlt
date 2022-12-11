import 'lib/tasks/destination/establish_connection.rake'
import 'lib/tasks/destination/tables_instantiate.rake'
import 'lib/tasks/destination/s_objects/completed_tasks/insert.rake'
import 'lib/tasks/destination/kbk/insert.rake'
import 'lib/tasks/destination/___del_ids/create_table.rake'
import 'lib/tasks/destination/entry/reference_handmade_vip/insert.rake'
import 'lib/tasks/destination/rem1/reference_handmade_vip/insert.rake'

namespace :destination do
  task :initialize => [
    'destination:establish_connection', 
    'destination:tables_instantiate!', 
    'destination:s_objects:completed_tasks:insert', 
    'destination:entry:reference_handmade_vip:insert', 
    'destination:rem1:reference_handmade_vip:insert', 
    'destination:kbk:insert',
    'destination:___del_ids:create_table',
  ]
end
