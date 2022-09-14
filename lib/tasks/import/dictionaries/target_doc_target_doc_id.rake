Dir[File.expand_path('../target_doc_target_doc_id/**/*.rake', __FILE__)].each {|path| import path}

namespace :import do
  namespace :dictionaries do
    namespace :target_doc_target_doc_id do
      task :tasks => [
        'import:dictionaries:target_doc_target_doc_id:destination:mss_objects_dicts:insert',
      ]
    end
  end
end
