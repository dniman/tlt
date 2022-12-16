namespace :corrs do
  namespace :destroy do

    task :tasks => [
      'corrs:destination:___del_ids:insert',

      # Документы
      'corrs:destination:mss_objcorr_docs:delete',

      # Параметры физического лица
      # Фамилия
      'corrs:destination:s_corr_app:object:column_person_fm:delete',

      # Имя
      'corrs:destination:s_corr_app:object:column_person_im:delete',
      
      # Отчество
      'corrs:destination:s_corr_app:object:column_person_ot:delete',
      
      # Дата рождения
      'corrs:destination:s_corr_app:object:column_person_birthdate:delete',
      
      # Пол
      'corrs:destination:s_corr_app:object:column_person_sex:delete',


      # Типы корреспондентов
      'corrs:destination:t_corr_dict:reference_corr_type:delete',

      'corrs:destination:mss_objcorr:delete',
      'corrs:destination:s_corr:delete',
      'corrs:destination:___del_ids:delete',
      'corrs:source:___ids:drop___link',
    ]

  end
end
