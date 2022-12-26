namespace :corrs do
  namespace :ul do
    namespace :import do

      task :tasks do
        Rake.invoke_task 'corrs:ul:source:___ids:insert', 'UNDELETABLE'
        Rake.invoke_task 'corrs:ul:source:___ids:add___link'
        Rake.invoke_task 'corrs:ul:destination:s_corr:insert'
        Rake.invoke_task 'corrs:ul:source:___ids:update_link'
        Rake.invoke_task 'corrs:ul:source:___ids:update___link'
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_mo_ref:insert'
        Rake.invoke_task 'corrs:ul:destination:t_corr_dict:reference_corr_type:insert'

        # Ф.И.О. руководителя
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_scorrapp:sca_fio_boss:insert'
        
        # Телефон руководителя
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_scorrapp:sca_phone_boss:insert'
        
        # Должность руководителя
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_scorrapp:sca_boss_dol:insert'
        
        # Ф.И.О. бухгалтера
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_scorrapp:sca_fio_buh:insert'
        
        # Телефон бухгалтера
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_scorrapp:sca_phone_buh:insert'
        
        # Отраслевой орган исполнительной власти
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_s_corr_ref:main_org:insert'
        
        # Юридический адрес
        Rake.invoke_task 'corrs:ul:destination:s_corr_app:object:column_dict_corr_address:insert'
        
        # Адрес почтовый
        Rake.invoke_task 'corrs:ul:destination:s_corr_app:object:reference_postal_address:insert'
        
        # ОКВЭД
        Rake.invoke_task 'corrs:ul:source:___ids:add___okved_code'
        Rake.invoke_task 'corrs:ul:source:___ids:add___okved_link'
        Rake.invoke_task 'corrs:ul:source:___ids:update___okved_code'
        Rake.invoke_task 'corrs:ul:source:___ids:update___okved_link'
        Rake.invoke_task 'corrs:ul:destination:t_corr_note:reference_okved:insert'
        
        # Используемый при импорте идентификатор 
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_scorrapp:signer_id:insert'
        
        # Банкрот 
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_dictstxt:bankrot_yl:insert'

        # МСП
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_dictstxt:mcp:insert'
        
        # Ликвидирован
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_dictstxt:liquidation_yl:insert'
        
        # ОКОНХ
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_simple:okonh:insert'
        
        # В банке 
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_simple:in_bank:insert'
        
        # БИК 
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_simple:bank_bik:insert'

        # Корр. счет
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_simple:corr_acc:insert'
        
        # Расчетный счет
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_simple:ras_account:insert'
        
        # Дата начала учета 
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_scorrapp:date_b_org:insert'
        
        # Дата окончания учета 
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_scorrapp:date_e_org:insert'

        # История адреса
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_simple:add_hist1:insert'
        
        # История юридического адреса
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_simple:corr_adr_ofic_hist:insert'

        # История почтового адреса
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_simple:corr_adr_post_hist:insert'
        
        # История наименования
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_simple:corr_name_hist:insert'
        
        # История краткого наименования
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_simple:corr_sname_hist:insert'
        
        # История инн
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_simple:corr_inn_hist:insert'
        
        # Отрасль
        Rake.invoke_task 'corrs:ul:source:___ids:add___industry_name'
        Rake.invoke_task 'corrs:ul:source:___ids:update___industry_name'
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_dictstxt:industry:insert'
        
        # КПП
        Rake.invoke_task 'corrs:ul:destination:s_corr_cpp:object:reference_cppu:insert'
        
        # Организационно-правовая форма (конвертация)
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_simple:okopf_convert:insert'
        
        # EMAIL
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_scorrapp:sca_email:insert'
        
        # Телефон
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_scorrapp:sca_corr_phone:insert'
        
        # ОГРН
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_scorrapp:sca_mss_ogrn:insert'
        
        # ОКПО
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_scorrapp:sca_mss_okpo:insert'
        
        # Отраслевой орган
        Rake.invoke_task 'corrs:ul:source:___ids:add___main_otr_name'
        Rake.invoke_task 'corrs:ul:source:___ids:update___main_otr_name'
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_dictstxt:main_otr:insert'
        
        # Категория пользователя
        Rake.invoke_task 'corrs:ul:source:___ids:add___kat_pol_name'
        Rake.invoke_task 'corrs:ul:source:___ids:update___kat_pol_name'
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_dictstxt:kat_pol:insert'
        
        # Предыдущее наименование
        Rake.invoke_task 'corrs:ul:destination:mss_viw_ocval_simple:creating_name_old:insert'

        # Документы
        Rake.invoke_task 'corrs:ul:destination:mss_objcorr_docs:insert'
        
        Rake.invoke_task 'corrs:ul:source:___ids:drop___link'
        Rake.invoke_task 'corrs:ul:source:___ids:drop___okved_link'
        Rake.invoke_task 'corrs:ul:source:___ids:drop___okved_code'
        Rake.invoke_task 'corrs:ul:source:___ids:drop___industry_name'
        Rake.invoke_task 'corrs:ul:source:___ids:drop___main_otr_name'
        Rake.invoke_task 'corrs:ul:source:___ids:drop___kat_pol_name'
      end

    end
  end
end
