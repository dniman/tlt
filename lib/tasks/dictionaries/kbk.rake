Dir[File.expand_path('../kbk/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :kbk do
    task :import do
      Rake.invoke_task 'dictionaries:kbk:source:___ids:insert'
      Rake.invoke_task 'dictionaries:kbk:destination:s_kbk:dictionary_department:insert'
      Rake.invoke_task 'dictionaries:kbk:destination:s_kbk:dictionary_income:insert'
      Rake.invoke_task 'dictionaries:kbk:destination:s_kbk:dictionary_program:insert'
      Rake.invoke_task 'dictionaries:kbk:destination:s_kbk:dictionary_item:insert'
      Rake.invoke_task 'dictionaries:kbk:destination:s_kbk:dictionary_kbk_inc:insert'
      
      Rake.invoke_task 'dictionaries:kbk:source:cls_kbk:add___link_department'
      Rake.invoke_task 'dictionaries:kbk:source:cls_kbk:add___link_income'
      Rake.invoke_task 'dictionaries:kbk:source:cls_kbk:add___link_program'
      Rake.invoke_task 'dictionaries:kbk:source:cls_kbk:add___link_item'
      Rake.invoke_task 'dictionaries:kbk:source:cls_kbk:add___link_kbk_inc'
      
      Rake.invoke_task 'dictionaries:kbk:source:cls_kbk:update___link_department'
      Rake.invoke_task 'dictionaries:kbk:source:cls_kbk:update___link_income'
      Rake.invoke_task 'dictionaries:kbk:source:cls_kbk:update___link_program'
      Rake.invoke_task 'dictionaries:kbk:source:cls_kbk:update___link_item'
      Rake.invoke_task 'dictionaries:kbk:source:cls_kbk:update___link_kbk_inc'
      Rake.invoke_task 'dictionaries:kbk:source:___ids:update_link'

      Rake.invoke_task 'dictionaries:kbk:destination:s_kbk_name:dictionary_department:insert'
      Rake.invoke_task 'dictionaries:kbk:destination:s_kbk_name:dictionary_income:insert'
      Rake.invoke_task 'dictionaries:kbk:destination:s_kbk_name:dictionary_program:insert'
      Rake.invoke_task 'dictionaries:kbk:destination:s_kbk_name:dictionary_item:insert'
      Rake.invoke_task 'dictionaries:kbk:destination:s_kbk_name:dictionary_kbk_inc:insert'

      Rake.invoke_task 'dictionaries:kbk:destination:t_kbk:ref_inc_adm:insert'
      Rake.invoke_task 'dictionaries:kbk:destination:t_kbk:ref_inc:insert'
      Rake.invoke_task 'dictionaries:kbk:destination:t_kbk:ref_inc_prog:insert'
      Rake.invoke_task 'dictionaries:kbk:destination:t_kbk:ref_inc_item:insert'
      
      Rake.invoke_task 'dictionaries:kbk:source:cls_kbk:drop___link_department'
      Rake.invoke_task 'dictionaries:kbk:source:cls_kbk:drop___link_income'
      Rake.invoke_task 'dictionaries:kbk:source:cls_kbk:drop___link_program'
      Rake.invoke_task 'dictionaries:kbk:source:cls_kbk:drop___link_item'
      Rake.invoke_task 'dictionaries:kbk:source:cls_kbk:drop___link_kbk_inc'
    end 
    
    task :destroy => [
      'dictionaries:kbk:destination:t_kbk:ref_inc_adm:delete',
      'dictionaries:kbk:destination:t_kbk:ref_inc:delete',
      'dictionaries:kbk:destination:t_kbk:ref_inc_prog:delete',
      'dictionaries:kbk:destination:t_kbk:ref_inc_item:delete',
      
      'dictionaries:kbk:destination:s_kbk_name:dictionary_kbk_inc:delete',
      'dictionaries:kbk:destination:s_kbk:dictionary_kbk_inc:delete',
      
      'dictionaries:kbk:source:cls_kbk:drop___link_department',
      'dictionaries:kbk:source:cls_kbk:drop___link_income',
      'dictionaries:kbk:source:cls_kbk:drop___link_program',
      'dictionaries:kbk:source:cls_kbk:drop___link_item',
      'dictionaries:kbk:source:cls_kbk:drop___link_kbk_inc',
    ]
  end
end
