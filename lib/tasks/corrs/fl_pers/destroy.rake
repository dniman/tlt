namespace :corrs do
  namespace :fl_pers do
    namespace :destroy do

      task :tasks => [
        'corrs:fl_pers:destination:___del_ids:insert',

        # Документы
        'corrs:fl_pers:destination:mss_objcorr_docs:delete',

        # Параметры физического лица
        # Фамилия
        'corrs:fl_pers:destination:s_corr_app:object:column_person_fm:delete',

        # Имя
        'corrs:fl_pers:destination:s_corr_app:object:column_person_im:delete',
        
        # Отчество
        'corrs:fl_pers:destination:s_corr_app:object:column_person_ot:delete',
        
        # Дата рождения
        'corrs:fl_pers:destination:s_corr_app:object:column_person_birthdate:delete',
        
        # Пол
        'corrs:fl_pers:destination:s_corr_app:object:column_person_sex:delete',
        
        # Место рождения
        'corrs:fl_pers:destination:s_corr_app:object:column_person_birthplace:delete',

        # СНИЛС
        'corrs:fl_pers:destination:s_corr_app:object:column_person_insur_num:delete',
        
        # Тип документа
        'corrs:fl_pers:destination:t_corr_dict:dictionary_person_passport:delete',
        'corrs:fl_pers:source:___ids:drop___doc_type_name',
        'corrs:fl_pers:source:___ids:drop___doc_type_link',
        
        # Номер документа 
        'corrs:fl_pers:destination:s_corr_app:object:column_person_doc_n:delete',
        
        # Дата документа 
        'corrs:fl_pers:destination:s_corr_app:object:column_person_doc_date:delete',
        
        # Кем выдан
        'corrs:fl_pers:destination:s_corr_app:object:column_person_doc_whom:delete',
        
        # Код подразделения 
        'corrs:fl_pers:destination:s_corr_app:object:column_person_ufms_code:delete',
        
        # Примечание
        'corrs:fl_pers:destination:s_corr_app:object:column_person_comment:delete',
        
        # Телефон
        'corrs:fl_pers:destination:s_corr_app:object:column_dict_pers_phone:delete',
        
        # ОГРНИП
        'corrs:fl_pers:destination:s_corr_app:object:mss_person_ogrnip:delete',
        
        # Дата регистрации ОГРНИП
        'corrs:fl_pers:destination:s_corr_app:object:mss_ref_corr_date_b:delete',

        # Мобильный телефон
        'corrs:fl_pers:destination:s_corr_app:object:column_person_phone:delete',
        
        # EMAIL
        'corrs:fl_pers:destination:s_corr_app:object:mss_person_ip_email:delete',

        # Расчетный счет
        'corrs:fl_pers:destination:s_corr_app:object:mss_person_ip_rasschet:delete',

        # Бик банка
        'corrs:fl_pers:source:___ids:drop___bank_link',
        'corrs:fl_pers:destination:s_corr_app:object:mss_person_ip_bik:delete',

        # Адрес по прописке
        'corrs:fl_pers:destination:s_corr_app:object:column_dict_corr_address:delete',

        # Адрес фактический
        'corrs:fl_pers:destination:s_corr_app:object:column_person_adr_fact:delete',

        # Адрес по прописке2
        'corrs:fl_pers:destination:s_corr_app:object:ref_mssdicorr_adrukl:delete',

        # Адрес фактический2
        'corrs:fl_pers:destination:s_corr_app:object:ref_mssdicorr_padrukl:delete',

        # Адрес почтовый
        'corrs:fl_pers:destination:s_corr_app:object:reference_postal_address:delete',

        # История адреса
        'corrs:fl_pers:destination:mss_objcorr_app:add_hist1:delete',
        
        # История юридического адреса
        'corrs:fl_pers:destination:mss_objcorr_app:corr_adr_ofic_hist:delete',

        # История почтового адреса
        'corrs:fl_pers:destination:mss_objcorr_app:corr_adr_post_hist:delete',

        # История наименования
        'corrs:fl_pers:destination:mss_objcorr_app:corr_name_hist:delete',
        
        # История краткого наименования
        'corrs:fl_pers:destination:mss_objcorr_app:corr_sname_hist:delete',
        
        # История инн
        'corrs:fl_pers:destination:mss_objcorr_app:corr_inn_hist:delete',
        
        # EMAIL
        'corrs:fl_pers:destination:mss_objcorr_app:sca_email:delete',
        'corrs:fl_pers:destination:s_corr_app:object:reference_email:delete',
        
        # Телефон 
        'corrs:fl_pers:destination:mss_objcorr_app:sca_corr_phone:delete',
        'corrs:fl_pers:destination:s_corr_app:object:column_dict_corr_phone:delete',

        # Дата гос. рег. прекращения деятельности 
        'corrs:fl_pers:destination:mss_objcorr_app:gos_reg_cessation_date:delete',
       
        # В банке 
        'corrs:fl_pers:destination:mss_objcorr_app:in_bank:delete',

        # БИК 
        'corrs:fl_pers:destination:mss_objcorr_app:bank_bik:delete',

        # Корр. счет
        'corrs:fl_pers:destination:mss_objcorr_app:corr_acc:delete',
        
        # Расчетный счет
        'corrs:fl_pers:destination:mss_objcorr_app:ras_account:delete',

        # Используемый при импорте идентификатор 
        # Идентификатор подписанта используемый при импорте
        'corrs:fl_pers:destination:mss_objcorr_app:signer_id:delete',
        'corrs:fl_pers:destination:s_corr_app:object:mss_ref_corr_signrcd:delete',
        
        # Банкрот 
        'corrs:fl_pers:destination:mss_objcorr_app:bankrot_fl:delete',
        
        # ОГРН
        'corrs:fl_pers:destination:mss_objcorr_app:sca_mss_ogrn:delete',
        'corrs:fl_pers:destination:s_corr_app:object:mss_ref_owner_ogrn:delete',

        # Субъект МСП
        'corrs:fl_pers:destination:mss_objcorr_app:mcp:delete',

        # ОКВЭД
        'corrs:fl_pers:destination:t_corr_note:reference_okved:delete',
        
        # ОКОНХ
        'corrs:fl_pers:destination:mss_objcorr_app:okonh:delete',
        
        # ОКПО
        'corrs:fl_pers:destination:mss_objcorr_app:sca_mss_okpo:delete',
        'corrs:fl_pers:destination:s_corr_app:object:okpo:delete',
        
        # Категория пользователя
        'corrs:fl_pers:destination:mss_objcorr_app:kat_pol:delete',

        # Типы корреспондентов
        'corrs:fl_pers:destination:t_corr_dict:reference_corr_type:delete',

        'corrs:fl_pers:destination:mss_objcorr:delete',
        'corrs:fl_pers:destination:s_corr:delete',
        'corrs:fl_pers:destination:___del_ids:delete',
        'corrs:fl_pers:source:___ids:drop___link',
        'corrs:fl_pers:source:___ids:drop___okved_code',
        'corrs:fl_pers:source:___ids:drop___okved_link',
        'corrs:fl_pers:source:___ids:drop___kat_pol_name',
      ]

    end
  end
end
