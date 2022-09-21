namespace :corrs do
  namespace :destroy do

    task :tasks => [
        'corrs:destination:t_corr_dict:reference_corr_type:delete',

        'corrs:destination:mss_objcorr:delete',
        'corrs:destination:s_corr:delete',
    ]

  end
end
