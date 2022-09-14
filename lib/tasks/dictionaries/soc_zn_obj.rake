Dir[File.expand_path('../soc_zn_obj/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :soc_zn_obj do
    task :import => [
      'dictionaries:soc_zn_obj:destination:mss_objects_dicts:insert',
    ]
    
    task :destroy => [
      'dictionaries:soc_zn_obj:destination:mss_objects_dicts:delete',
    ]
  end
end
