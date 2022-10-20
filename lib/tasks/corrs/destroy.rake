namespace :corrs do
  namespace :destroy do

    task :tasks => [
      # Параметры физического лица
      # Фамилия
      'corrs:destination:s_corr_app:object:column_person_fm:delete',

      # Типы корреспондентов
      'corrs:destination:t_corr_dict:reference_corr_type:delete',

      'corrs:destination:mss_objcorr:delete',
      'corrs:destination:s_corr:delete',
      'corrs:source:ids:drop___link',
    ]

  end
end
