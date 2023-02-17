Dir[File.expand_path('../object_references/**/*.rake', __FILE__)].each {|path| import path}

namespace :object_references do
  namespace :import do

    task :tasks do 
      
      # Составные части объекта
      Rake.invoke_task 'object_references:destination:mss_objects_struelem:insert'
      
    end 

  end
end
