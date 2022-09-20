namespace :corrs do
  namespace :destroy do

    task :tasks => [
        'corrs:destination:mss_objcorr:delete',
        'corrs:destination:s_corr:delete',
    ]

  end
end
