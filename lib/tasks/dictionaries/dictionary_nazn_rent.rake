Dir[File.expand_path('../dictionary_nazn_rent/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :dictionary_nazn_rent do
    task :import do
      Rake.invoke_task 'dictionaries:dictionary_nazn_rent:source:___ids:insert'
      Rake.invoke_task 'dictionaries:dictionary_nazn_rent:source:___ids:update_link'
      Rake.invoke_task 'dictionaries:dictionary_nazn_rent:destination:s_nazn:insert'
      Rake.invoke_task 'dictionaries:dictionary_nazn_rent:destination:s_nazn:update_link_up'
    end 
    
    task :destroy => [
      'dictionaries:dictionary_nazn_rent:destination:s_nazn:delete',
    ]
  end
end
