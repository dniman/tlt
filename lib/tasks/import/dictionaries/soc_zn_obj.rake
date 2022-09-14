Dir[File.expand_path('../soc_zn_obj/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :dictionaries do
    namespace :soc_zn_obj do
      task :tasks => [
        'import:dictionaries:soc_zn_obj:destination:mss_objects_dicts:insert',
      ]
    end
  end
end
