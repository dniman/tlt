namespace :corrs do
  namespace :import do

    task :tasks do
      Rake.invoke_task 'corrs:source:___ids:insert', 'UNDELETABLE'
      Rake.invoke_task 'corrs:source:___ids:add___link'
      Rake.invoke_task 'corrs:destination:s_corr:insert'
      Rake.invoke_task 'corrs:source:___ids:update_link'
      Rake.invoke_task 'corrs:destination:mss_viw_ocval_mo_ref:insert'
      Rake.invoke_task 'corrs:destination:t_corr_dict:reference_corr_type:insert'

      # Параметры физического лица
      # Фамилия
      Rake.invoke_task 'corrs:destination:s_corr_app:object:column_person_fm:insert'

      # Имя 
      Rake.invoke_task 'corrs:destination:s_corr_app:object:column_person_im:insert'

      # Отчество
      Rake.invoke_task 'corrs:destination:s_corr_app:object:column_person_ot:insert'

      # Дата рождения
      Rake.invoke_task 'corrs:destination:s_corr_app:object:column_person_birthdate:insert'
      
      # Пол
      Rake.invoke_task 'corrs:destination:s_corr_app:object:column_person_sex:insert'

      # Документы
      Rake.invoke_task 'corrs:destination:mss_objcorr_docs:insert'
      
      Rake.invoke_task 'corrs:source:___ids:drop___link'
    end

  end
end
