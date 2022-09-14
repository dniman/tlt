Dir[File.expand_path('../grounds_funk_using_grounds_funk_using_id/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :dictionaries do
    namespace :grounds_funk_using_grounds_funk_using_id do
      task :tasks => [
        'import:dictionaries:grounds_funk_using_grounds_funk_using_id:destination:mss_objects_dicts:insert',
      ]
    end
  end
end
