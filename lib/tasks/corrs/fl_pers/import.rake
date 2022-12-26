namespace :corrs do
  namespace :fl_pers do
    namespace :import do

      task :tasks do
        Rake.invoke_task 'corrs:fl_pers:source:___ids:insert', 'UNDELETABLE'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:add___link'
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr:insert'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:update_link'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:update___link'
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_mo_ref:insert'
        Rake.invoke_task 'corrs:fl_pers:destination:t_corr_dict:reference_corr_type:insert'

        # Параметры физического лица
        # Фамилия
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:column_person_fm:insert'

        # Имя 
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:column_person_im:insert'

        # Отчество
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:column_person_ot:insert'

        # Дата рождения
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:column_person_birthdate:insert'
        
        # Пол
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:column_person_sex:insert'

        # Место рождения
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:column_person_birthplace:insert'

        # СНИЛС
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:column_person_insur_num:insert'
        
        # Тип документа
        Rake.invoke_task 'corrs:fl_pers:source:___ids:add___doc_type_name'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:add___doc_type_link'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:update___doc_type_name'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:update___doc_type_link'
        Rake.invoke_task 'corrs:fl_pers:destination:t_corr_dict:dictionary_person_passport:insert'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:drop___doc_type_name'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:drop___doc_type_link'
        
        # Номер документа 
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:column_person_doc_n:insert'
        
        # Дата документа 
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:column_person_doc_date:insert'
        
        # Кем выдан
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:column_person_doc_whom:insert'
        
        # Код подразделения 
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:column_person_ufms_code:insert'
        
        # Примечание
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:column_person_comment:insert'

        # Телефон
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:column_dict_pers_phone:insert'
        
        # ОГРНИП
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:mss_person_ogrnip:insert'

        # Дата регистрации ОГРНИП
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:mss_ref_corr_date_b:insert'

        # Мобильный телефон
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:column_person_phone:insert'
        
        # EMAIL
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:mss_person_ip_email:insert'

        # Расчетный счет
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:mss_person_ip_rasschet:insert'
        
        # Бик банка
        Rake.invoke_task 'corrs:fl_pers:source:___ids:add___bank_link'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:update___bank_link'
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:mss_person_ip_bik:insert'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:drop___bank_link'
        
        # Адрес по прописке
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:column_dict_corr_address:insert'

        # Адрес фактический
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:column_person_adr_fact:insert'

        # Адрес по прописке2
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:ref_mssdicorr_adrukl:insert'

        # Адрес фактический2
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:ref_mssdicorr_padrukl:insert'
        
        # Адрес почтовый
        Rake.invoke_task 'corrs:fl_pers:destination:s_corr_app:object:reference_postal_address:insert'

        # История адреса
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_simple:add_hist1:insert'
        
        # История юридического адреса
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_simple:corr_adr_ofic_hist:insert'

        # История почтового адреса
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_simple:corr_adr_post_hist:insert'
        
        # История наименования
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_simple:corr_name_hist:insert'
        
        # История краткого наименования
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_simple:corr_sname_hist:insert'
        
        # История инн
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_simple:corr_inn_hist:insert'

        # EMAIL
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_scorrapp:sca_email:insert'
        
        # Телефон
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_scorrapp:sca_corr_phone:insert'

        # Дата гос. рег. прекращения деятельности 
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_scorrapp:gos_reg_cessation_date:insert'

        # В банке 
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_simple:in_bank:insert'
        
        # БИК 
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_simple:bank_bik:insert'

        # Корр. счет
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_simple:corr_acc:insert'
        
        # Расчетный счет
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_simple:ras_account:insert'

        # Используемый при импорте идентификатор 
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_scorrapp:signer_id:insert'

        # Банкрот 
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_dictstxt:bankrot_fl:insert'

        # ОГРН
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_scorrapp:sca_mss_ogrn:insert'
        
        # МСП
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_dictstxt:mcp:insert'
        
        # ОКВЭД
        Rake.invoke_task 'corrs:fl_pers:source:___ids:add___okved_code'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:add___okved_link'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:update___okved_code'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:update___okved_link'
        Rake.invoke_task 'corrs:fl_pers:destination:t_corr_note:reference_okved:insert'
        
        # ОКОНХ
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_simple:okonh:insert'

        # ОКПО
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_scorrapp:sca_mss_okpo:insert'
        
        # Категория пользователя
        Rake.invoke_task 'corrs:fl_pers:source:___ids:add___kat_pol_name'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:update___kat_pol_name'
        Rake.invoke_task 'corrs:fl_pers:destination:mss_viw_ocval_dictstxt:kat_pol:insert'

        # Документы
        Rake.invoke_task 'corrs:fl_pers:destination:mss_objcorr_docs:insert'
        
        Rake.invoke_task 'corrs:fl_pers:source:___ids:drop___link'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:drop___okved_link'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:drop___okved_code'
        Rake.invoke_task 'corrs:fl_pers:source:___ids:drop___kateg_pol_name'
      end

    end
  end
end
