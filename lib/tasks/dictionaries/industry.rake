Dir[File.expand_path('../industry/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :industry do
    task :import do
      Rake.invoke_task 'dictionaries:industry:source:___industries:create_table', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:industry:source:___industries:insert', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:industry:source:___ids:insert', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:industry:destination:mss_objcorr_dictsimptext:insert'
      Rake.invoke_task 'dictionaries:industry:source:___ids:update_link'
    end 
    
    task :destroy => [
      'dictionaries:industry:destination:___del_ids:insert',
      'dictionaries:industry:destination:mss_objcorr_dictsimptext:delete',
      'dictionaries:industry:destination:___del_ids:delete'
    ]
  end
end
