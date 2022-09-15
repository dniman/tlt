Dir[File.expand_path('../grounds_release_release_id/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :grounds_release_release_id do
    task :import => [
      'dictionaries:grounds_release_release_id:destination:mss_objects_dicts:insert',
    ]
    
    task :destroy => [
      'dictionaries:grounds_release_release_id:destination:mss_objects_dicts:delete',
    ]
  end
end
