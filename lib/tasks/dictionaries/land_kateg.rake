Dir[File.expand_path('../land_kateg/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :land_kateg do
    task :import => [
      'dictionaries:land_kateg:destination:mss_objects_dicts:insert',
    ]
    
    task :destroy => [
      'dictionaries:land_kateg:destination:mss_objects_dicts:delete',
    ]
  end
end
