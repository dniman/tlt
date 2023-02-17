#Dir[File.expand_path('../object_references/**/*.rake', __FILE__)].each {|path| import path}
import 'lib/tasks/object_references/destination/___del_ids/insert.rake'
import 'lib/tasks/object_references/destination/mss_objects_struelem/delete.rake'
import 'lib/tasks/object_references/destination/___del_ids/delete.rake'

namespace :object_references do
  namespace :destroy do
    task :tasks => [
      'object_references:destination:___del_ids:insert',
      
      # Составные части объектов
      'object_references:destination:mss_objects_struelem:delete',

      'object_references:destination:___del_ids:delete',
    ]
  end
end
