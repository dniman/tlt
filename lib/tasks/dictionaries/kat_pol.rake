Dir[File.expand_path('../kat_pol/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :kat_pol do
    task :import do
      Rake.invoke_task 'dictionaries:kat_pol:source:___kat_pols:create_table', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:kat_pol:source:___kat_pols:insert', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:kat_pol:source:___ids:insert', 'UNDELETABLE'
      Rake.invoke_task 'dictionaries:kat_pol:destination:mss_objcorr_dictsimptext:insert'
      Rake.invoke_task 'dictionaries:kat_pol:source:___ids:update_link'
    end 
    
    task :destroy => [
      'dictionaries:kat_pol:destination:___del_ids:insert',
      'dictionaries:kat_pol:destination:mss_objcorr_distsimptext:delete',
      'dictionaries:kat_pol:destination:___del_ids:delete'
    ]
  end
end
