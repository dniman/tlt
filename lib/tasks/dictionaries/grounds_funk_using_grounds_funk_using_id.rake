Dir[File.expand_path('../grounds_funk_using_grounds_funk_using_id/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :grounds_funk_using_grounds_funk_using_id do
    task :import => [
      'dictionaries:grounds_funk_using_grounds_funk_using_id:destination:mss_objects_dicts:insert',
    ]
    
    task :destroy => [
      'dictionaries:grounds_funk_using_grounds_funk_using_id:destination:mss_objects_dicts:delete',
    ]
  end
end
