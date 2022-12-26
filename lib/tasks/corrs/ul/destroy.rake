namespace :corrs do
  namespace :ul do
    namespace :destroy do

      task :tasks => [
        'corrs:ul:destination:___del_ids:insert',

        # Документы
        'corrs:ul:destination:mss_objcorr_docs:delete',
        
        # Ф.И.О. руководителя
        'corrs:ul:destination:mss_objcorr_app:sca_fio_boss:delete',
        'corrs:ul:destination:s_corr_app:object:column_dict_corr_fio_boss:delete',
        
        # Телефон руководителя
        'corrs:ul:destination:mss_objcorr_app:sca_phone_boss:delete',
        'corrs:ul:destination:s_corr_app:object:column_dict_corr_phone_boss:delete',
        
        # Должность руководителя
        'corrs:ul:destination:mss_objcorr_app:sca_boss_dol:delete',
        'corrs:ul:destination:s_corr_app:object:reference_boss_dol:delete',
        
        # Ф.И.О. бухгалтера
        'corrs:ul:destination:mss_objcorr_app:sca_fio_buh:delete',
        'corrs:ul:destination:s_corr_app:object:column_dict_corr_fio_buh:delete',
        
        # Телефон бухгалтера
        'corrs:ul:destination:mss_objcorr_app:sca_phone_buh:delete',
        'corrs:ul:destination:s_corr_app:object:column_dict_corr_phone_buh:delete',
        
        # Отраслевой орган исполнительной власти
        'corrs:ul:destination:mss_objcorr_app:main_org:delete',
        'corrs:ul:destination:s_corr_app:object:cole_dict_corr_check_main_org:delete',

        # Юридический адрес
        'corrs:ul:destination:s_corr_app:object:column_dict_corr_address:delete',
        'corrs:ul:destination:s_corr_app:object:ref_mssdicorr_adrukl:delete',
        'corrs:ul:destination:s_corr_app:object:ref_mssdicorr_padrukl:delete',
        
        # Адрес почтовый
        'corrs:ul:destination:s_corr_app:object:reference_postal_address:delete',
        
        # ОКВЭД
        'corrs:ul:destination:t_corr_note:reference_okved:delete',
        
        # Используемый при импорте идентификатор 
        'corrs:ul:destination:mss_objcorr_app:signer_id:delete',
        'corrs:ul:destination:s_corr_app:object:mss_ref_corr_signrcd:delete',
        
        # Банкрот 
        'corrs:ul:destination:mss_objcorr_app:bankrot_yl:delete',
        
        # Субъект МСП
        'corrs:ul:destination:mss_objcorr_app:mcp:delete',
        
        # Ликвидирован
        'corrs:ul:destination:mss_objcorr_app:liquidation_yl:delete',
        
        # ОКОНХ
        'corrs:ul:destination:mss_objcorr_app:okonh:delete',
        
        # В банке 
        'corrs:ul:destination:mss_objcorr_app:in_bank:delete',

        # БИК 
        'corrs:ul:destination:mss_objcorr_app:bank_bik:delete',

        # Корр. счет
        'corrs:ul:destination:mss_objcorr_app:corr_acc:delete',
        
        # Расчетный счет
        'corrs:ul:destination:mss_objcorr_app:ras_account:delete',
        
        # Дата начала учета 
        'corrs:ul:destination:mss_objcorr_app:date_b_org:delete',
        'corrs:ul:destination:s_corr_app:object:mss_ref_corr_date_b_org:delete',
        
        # Дата конца учета 
        'corrs:ul:destination:mss_objcorr_app:date_e_org:delete',
        'corrs:ul:destination:s_corr_app:object:mss_ref_corr_date_e_org:delete',

        # История адреса
        'corrs:ul:destination:mss_objcorr_app:add_hist1:delete',
        
        # История юридического адреса
        'corrs:ul:destination:mss_objcorr_app:corr_adr_ofic_hist:delete',

        # История почтового адреса
        'corrs:ul:destination:mss_objcorr_app:corr_adr_post_hist:delete',
        
        # История наименования
        'corrs:ul:destination:mss_objcorr_app:corr_name_hist:delete',
        
        # История краткого наименования
        'corrs:ul:destination:mss_objcorr_app:corr_sname_hist:delete',
        
        # История инн
        'corrs:ul:destination:mss_objcorr_app:corr_inn_hist:delete',
        
        # Отрасль
        'corrs:ul:destination:mss_objcorr_app:industry:delete',
        
        # КПП
        'corrs:ul:destination:s_corr_cpp:object:reference_cppu:delete',
        
        # Организационно-правовая форма(конвертация)
        'corrs:ul:destination:mss_objcorr_app:okopf_convert:delete',
        
        # EMAIL
        'corrs:ul:destination:mss_objcorr_app:sca_email:delete',
        'corrs:ul:destination:s_corr_app:object:reference_email:delete',
        
        # Телефон 
        'corrs:ul:destination:mss_objcorr_app:sca_corr_phone:delete',
        'corrs:ul:destination:s_corr_app:object:column_dict_corr_phone:delete',
        
        # ОГРН
        'corrs:ul:destination:mss_objcorr_app:sca_mss_ogrn:delete',
        'corrs:ul:destination:s_corr_app:object:mss_ref_owner_ogrn:delete',
        
        # ОКПО
        'corrs:ul:destination:mss_objcorr_app:sca_mss_okpo:delete',
        'corrs:ul:destination:s_corr_app:object:okpo:delete',
        
        # Отраслевой орган
        'corrs:ul:destination:mss_objcorr_app:main_otr:delete',
        
        # Категория пользователя
        'corrs:ul:destination:mss_objcorr_app:kat_pol:delete',
        
        # Предыдущее наименование
        'corrs:ul:destination:mss_objcorr_app:creating_name_old:delete',

        # Типы корреспондентов
        'corrs:ul:destination:t_corr_dict:reference_corr_type:delete',

        # mss_corr_chief
        'corrs:ul:destination:mss_corr_chief:delete',

        'corrs:ul:destination:mss_objcorr:delete',
        'corrs:ul:destination:s_corr:delete',
        'corrs:ul:destination:___del_ids:delete',
        'corrs:ul:source:___ids:drop___link',
        'corrs:ul:source:___ids:drop___okved_code',
        'corrs:ul:source:___ids:drop___okved_link',
        'corrs:ul:source:___ids:drop___industry_name',
        'corrs:ul:source:___ids:drop___main_otr_name',
        'corrs:ul:source:___ids:drop___kat_pol_name',
      ]

    end
  end
end
