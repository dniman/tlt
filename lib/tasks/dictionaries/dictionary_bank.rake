Dir[File.expand_path('../dictionary_bank/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :dictionary_bank do
    task :import do
      Rake.invoke_task 'dictionaries:dictionary_bank:source:___client_banks:create_table', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:dictionary_bank:source:___client_banks:insert', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:dictionary_bank:source:___ids:insert', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:dictionary_bank:destination:s_bank:insert'
      Rake.invoke_task 'dictionaries:dictionary_bank:source:___ids:update_link'
    end 
    
    task :destroy => [
      'dictionaries:dictionary_bank:destination:___del_ids:insert',
      'dictionaries:dictionary_bank:destination:s_bank:delete',
      'dictionaries:dictionary_bank:destination:___del_ids:delete'
    ]
  end
end
