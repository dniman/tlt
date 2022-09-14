Dir[File.expand_path('../obj_zkx/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :obj_zkx do
    task :import => [
      'dictionaries:obj_zkx:destination:mss_objects_dicts:insert',
    ]
    
    task :destroy => [
      'dictionaries:obj_zkx:destination:mss_objects_dicts:delete',
    ]
  end
end
