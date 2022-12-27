Dir[File.expand_path('../main_otr/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :main_otr do
    task :import do
      Rake.invoke_task 'dictionaries:main_otr:source:___main_otrs:create_table', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:main_otr:source:___main_otrs:insert', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:main_otr:source:___ids:insert', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:main_otr:destination:mss_objcorr_dictsimptext:insert'
      Rake.invoke_task 'dictionaries:main_otr:source:___ids:update_link'
    end 
    
    task :destroy => [
      'dictionaries:main_otr:destination:___del_ids:insert',
      'dictionaries:main_otr:destination:mss_objcorr_dictsimptext:delete',
      'dictionaries:main_otr:destination:___del_ids:delete'
    ]
  end
end
