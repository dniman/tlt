Dir[File.expand_path('../dictionary_agree_mode/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :dictionary_agree_mode do
    task :import do
      Rake.invoke_task 'dictionaries:dictionary_agree_mode:destination:s_note:insert'
    end 
    
    task :destroy => [
      'dictionaries:dictionary_agree_mode:destination:s_note:delete',
    ]
  end
end
