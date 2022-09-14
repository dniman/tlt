Dir[File.expand_path('../land_ownership/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :land_ownership do
    task :import => [
      'dictionaries:land_ownership:destination:mss_objects_dicts:insert',
    ]
    
    task :import => [
      'dictionaries:land_ownership:destination:mss_objects_dicts:delete',
    ]
  end
end
