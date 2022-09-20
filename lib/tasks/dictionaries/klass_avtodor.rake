Dir[File.expand_path('../klass_avtodor/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :klass_avtodor do
    task :import do
      Rake.invoke_task 'dictionaries:klass_avtodor:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:klass_avtodor:destination:mss_objects_dicts:delete',
    ]
  end
end
