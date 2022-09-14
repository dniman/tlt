Dir[File.expand_path('../land_used/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :land_used do
    task :import => [
      'dictionaries:land_used:destination:mss_objects_dicts:insert',
    ]
    
    task :destroy => [
      'dictionaries:land_used:destination:mss_objects_dicts:delete',
    ]
  end
end
