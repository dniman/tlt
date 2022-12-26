Dir[File.expand_path('../destination/*.rb', __FILE__)].each {|path| require path}

module Destination
  TABLES = [
    :mss_objects,
    :mss_objects_types,
    :mss_objects_dicts,
    :mss_objects_adr,
    :mss_adr,
    :mss_objects_params,
    :mss_objects_app,
    :s_note,
    :s_objects,
    :s_corr,
    :mss_objcorr,
    :t_corr_dict,
    :mss_docs,
    :mss_oac_rowstates,
    :mss_objcorr_types,
    :mss_objcorr_prop_ref,
    :mss_doc_types,
    :mss_viw_ocval_mo_ref,
    :mss_objcorr_props,
    :s_kbk,
    :s_kbk_name,
    :t_kbk,
    :mss_objects_parentland,
    :s_corr_app,
    :v_mss_agreements_types,
    :agreement,
    :paycard,
    :s_account,
    :s_nazn,
    :paycardobjects,
    :s_baccount,
    :___charge_save,
    :rem3,
    :rem2_app,
    :rem2,
    :rem1,
    :charge,
    :___sys_extrem,
    :extrem,
    :mss_moves_key,
    :mss_v_moves_types,
    :mss_movs,
    :mss_moves_causes_b,
    :___del_ids,
    :mss_decommission_causes,
    :entry,
    :t_rem1,
    :t_charge,
    :agreement_sign,
    :paycard_sign,
    :mss_reestr_partitions,
    :mss_moves_mss_objects,
    :mss_detail_list,
    :mss_docs_roles_in_operations,
    :mss_objcorr_docs,
    :s_bank,
    :mss_viw_ocval_simple,
    :mss_viw_ocval_scorrapp,
    :mss_objcorr_app,
    :mss_objcorr_dictsimptext,
    :mss_viw_ocval_dictstxt,
    :t_corr_note,
    :mss_corr_chief,
    :mss_viw_ocval_s_corr_ref,
    :s_corr_cpp,
  ]

  class << self
    def execute_query(query)
      connection = Database.destination.sqlsent? ? Database.destination2 : Database.destination
      Database.execute_query(connection, query)
    end

    def set_engine!
      Database.set_engine(Database.destination_engine)
    end
    
    def engine_owner?
      Arel::Table.engine == Database.destination_engine
    end
    
    def tables_instantiate!
      TABLES.each do |table| 
        instance_eval "@#{table} ||= Arel::Table.new(:#{table})"
        define_singleton_method(table) do
          set_engine! unless engine_owner?
          instance_variable_get("@#{table}")
        end
      end

      Destination::MssObjects.const_set(
        :DICTIONARY_MSS_OBJECTS, 
        execute_query("select dbo.obj_id('DICTIONARY_MSS_OBJECTS')").entries.first.values.first
      )

      Destination::MssObjectsDicts.const_set(
        :DICTIONARY_LAND_KVARTALS,
        execute_query("select dbo.obj_id('DICTIONARY_LAND_KVARTALS')").entries.first.values.first
      )
      
      Destination::SNote.const_set(
        :COMPLETED_TASKS,
        Destination::SObjects.obj_id('COMPLETED_TASKS')
      )

      Destination::SCorr.const_set(
        :DICTIONARY_CORR,
        Destination::SObjects.obj_id('DICTIONARY_CORR')
      )
      
      Destination::SCorr.const_set(
        :DICTIONARY_CORR_TYPE,
        Destination::SObjects.obj_id('DICTIONARY_CORR_TYPE')
      )
      
      Destination::TCorrDict.const_set(
        :REFERENCE_CORR_TYPE,
        Destination::SObjects.obj_id('REFERENCE_CORR_TYPE')
      )
      
      Destination::MssDocTypes.const_set(
        :MSS_DOCS_COMMON,
        Destination::SObjects.obj_id('MSS_DOCS_COMMON')
      )
      
      Destination::SKbk.const_set(
        :DICTIONARY_DEPARTMENT,
        Destination::SObjects.obj_id('DICTIONARY_DEPARTMENT')
      )
      
      Destination::SKbk.const_set(
        :DICTIONARY_INCOME,
        Destination::SObjects.obj_id('DICTIONARY_INCOME')
      )
      
      Destination::SKbk.const_set(
        :DICTIONARY_PROGRAM,
        Destination::SObjects.obj_id('DICTIONARY_PROGRAM')
      )
      
      Destination::SKbk.const_set(
        :DICTIONARY_ITEM,
        Destination::SObjects.obj_id('DICTIONARY_ITEM')
      )
      
      Destination::SKbk.const_set(
        :DICTIONARY_KBK_INC,
        Destination::SObjects.obj_id('DICTIONARY_KBK_INC')
      )
      
      Destination::TKbk.const_set(
        :REF_INC_ADM,
        Destination::SObjects.obj_id('REF_INC_ADM')
      )
      
      Destination::TKbk.const_set(
        :REF_INC,
        Destination::SObjects.obj_id('REF_INC')
      )
      
      Destination::TKbk.const_set(
        :REF_INC_PROG,
        Destination::SObjects.obj_id('REF_INC_PROG')
      )
      
      Destination::TKbk.const_set(
        :REF_INC_ITEM,
        Destination::SObjects.obj_id('REF_INC_ITEM')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_PERSON_FM,
        Destination::SObjects.obj_id('COLUMN_PERSON_FM')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_PERSON_IM,
        Destination::SObjects.obj_id('COLUMN_PERSON_IM')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_PERSON_OT,
        Destination::SObjects.obj_id('COLUMN_PERSON_OT')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_PERSON_BIRTHDATE,
        Destination::SObjects.obj_id('COLUMN_PERSON_BIRTHDATE')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_PERSON_SEX,
        Destination::SObjects.obj_id('COLUMN_PERSON_SEX')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_PERSON_BIRTHPLACE,
        Destination::SObjects.obj_id('COLUMN_PERSON_BIRTHPLACE')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_PERSON_INSUR_NUM,
        Destination::SObjects.obj_id('COLUMN_PERSON_INSUR_NUM')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_PERSON_DOC_N,
        Destination::SObjects.obj_id('COLUMN_PERSON_DOC_N')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_PERSON_DOC_WHOM,
        Destination::SObjects.obj_id('COLUMN_PERSON_DOC_WHOM')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_PERSON_DOC_DATE,
        Destination::SObjects.obj_id('COLUMN_PERSON_DOC_DATE')
      )
      
      Destination::TCorrDict.const_set(
        :DICTIONARY_PERSON_PASSPORT,
        Destination::SObjects.obj_id('DICTIONARY_PERSON_PASSPORT')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_PERSON_UFMS_CODE,
        Destination::SObjects.obj_id('COLUMN_PERSON_UFMS_CODE')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_PERSON_COMMENT,
        Destination::SObjects.obj_id('COLUMN_PERSON_COMMENT')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_DICT_PERS_PHONE,
        Destination::SObjects.obj_id('COLUMN_DICT_PERS_PHONE')
      )
      
      Destination::SCorrApp.const_set(
        :MSS_PERSON_OGRNIP,
        Destination::SObjects.obj_id('MSS_PERSON_OGRNIP')
      )

      Destination::SCorrApp.const_set(
        :MSS_REF_CORR_DATE_B,
        Destination::SObjects.obj_id('MSS_REF_CORR_DATE_B')
      )
      
      Destination::SCorrApp.const_set(
        :MSS_PERSON_IP_EMAIL,
        Destination::SObjects.obj_id('MSS_PERSON_IP_EMAIL')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_PERSON_PHONE,
        Destination::SObjects.obj_id('COLUMN_PERSON_PHONE')
      )
      
      Destination::SCorrApp.const_set(
        :MSS_PERSON_IP_RASSCHET,
        Destination::SObjects.obj_id('MSS_PERSON_IP_RASSCHET')
      )
      
      Destination::SCorrApp.const_set(
        :MSS_PERSON_IP_BIK,
        Destination::SObjects.obj_id('MSS_PERSON_IP_BIK')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_DICT_CORR_ADDRESS,
        Destination::SObjects.obj_id('COLUMN_DICT_CORR_ADDRESS')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_PERSON_ADR_FACT,
        Destination::SObjects.obj_id('COLUMN_PERSON_ADR_FACT')
      )
      
      Destination::SCorrApp.const_set(
        :REF_MSSDICORR_ADRUKL,
        Destination::SObjects.obj_id('REF_MSSDICORR_ADRUKL')
      )
      
      Destination::SCorrApp.const_set(
        :REF_MSSDICORR_PADRUKL,
        Destination::SObjects.obj_id('REF_MSSDICORR_PADRUKL')
      )
      
      Destination::SCorrApp.const_set(
        :REFERENCE_POSTAL_ADDRESS,
        Destination::SObjects.obj_id('REFERENCE_POSTAL_ADDRESS')
      )
      
      Destination::SCorrApp.const_set(
        :MSS_REF_CORR_DATE_B_ORG,
        Destination::SObjects.obj_id('MSS_REF_CORR_DATE_B_ORG')
      )
      
      Destination::SCorrApp.const_set(
        :MSS_REF_CORR_DATE_E_ORG,
        Destination::SObjects.obj_id('MSS_REF_CORR_DATE_E_ORG')
      )

      Destination::MssOacRowstates.const_set(
        :CURRENT,
        begin
          query = 
            Destination.mss_oac_rowstates
            .project(Destination.mss_oac_rowstates[:link])
            .where(Destination.mss_oac_rowstates[:code].eq("current"))
          Destination.execute_query(query.to_sql).entries.first["link"]
        end
      )
      
      Destination::TRem1.const_set(
        :DOCUMENTS_ADM_VIP,
        Destination::SObjects.obj_id('DOCUMENTS_ADM_VIP')
      )
      
      Destination::TRem1.const_set(
        :CHAIN_PP_ADM,
        Destination::SObjects.obj_id('CHAIN_PP_ADM')
      )
      
      Destination::Rem1.const_set(
        :DOCUMENTS_0401003A,
        Destination::SObjects.obj_id('DOCUMENTS_0401003A')
      )
      
      Destination::TCharge.const_set(
        :REFERENCE_PAY_CREDIT,
        Destination::SObjects.obj_id('REFERENCE_PAY_CREDIT')
      )
      
      Destination::TCharge.const_set(
        :REFERENCE_PAY_DEBIT,
        Destination::SObjects.obj_id('REFERENCE_PAY_DEBIT')
      )

      Destination::TCorrNote.const_set(
        :REFERENCE_OKVED,
        Destination::SObjects.obj_id('REFERENCE_OKVED')
      )
      
      Destination::SNote.const_set(
        :RCPT_OKVED,
        Destination::SObjects.obj_id('RCPT_OKVED')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_DICT_CORR_PHONE,
        Destination::SObjects.obj_id('COLUMN_DICT_CORR_PHONE')
      )
      
      Destination::SCorrApp.const_set(
        :MSS_REF_CORR_SIGNRCD,
        Destination::SObjects.obj_id('MSS_REF_CORR_SIGNRCD')
      )
      
      Destination::SCorrApp.const_set(
        :MSS_REF_OWNER_OGRN,
        Destination::SObjects.obj_id('MSS_REF_OWNER_OGRN')
      )
      
      Destination::SCorrApp.const_set(
        :REFERENCE_EMAIL,
        Destination::SObjects.obj_id('REFERENCE_EMAIL')
      )
      
      Destination::SCorrApp.const_set(
        :OKPO,
        Destination::SObjects.obj_id('OKPO')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_DICT_CORR_FIO_BOSS,
        Destination::SObjects.obj_id('COLUMN_DICT_CORR_FIO_BOSS')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_DICT_CORR_PHONE_BOSS,
        Destination::SObjects.obj_id('COLUMN_DICT_CORR_PHONE_BOSS')
      )
      
      Destination::SCorrApp.const_set(
        :REFERENCE_BOSS_DOL,
        Destination::SObjects.obj_id('REFERENCE_BOSS_DOL')
      )
      
      Destination::SCorrApp.const_set(
        :COLE_DICT_CORR_CHECK_MAIN_ORG,
        Destination::SObjects.obj_id('COLE_DICT_CORR_CHECK_MAIN_ORG')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_DICT_CORR_FIO_BUH,
        Destination::SObjects.obj_id('COLUMN_DICT_CORR_FIO_BUH')
      )
      
      Destination::SCorrApp.const_set(
        :COLUMN_DICT_CORR_PHONE_BUH,
        Destination::SObjects.obj_id('COLUMN_DICT_CORR_PHONE_BUH')
      )
      
      Destination::SCorrCpp.const_set(
        :REFERENCE_CPPU,
        Destination::SObjects.obj_id('REFERENCE_CPPU')
      )

      nil
    end

    def tables
      instance_variables.delete_if do |var|
        var == :@link_mo
      end
    end
    
    def link_mo
      @link_mo ||= begin
        sql = "select link from mss_current_user_mo_access()"
        execute_query(sql).entries.first["link"]
      end
    end
    
    def link_oktmo
      @link_oktmo ||= begin
        sql = "select oktmo from mss_mo where mo_link = (select link from mss_current_user_mo_access())"
        execute_query(sql).entries.first["oktmo"]
      end
    end
    
    def table_exists?(name)
      sql =<<~SQL
        select case when object_id(N'[dbo].[#{ name }]') is null then 0 else 1 end
      SQL

      result = execute_query(sql).entries.first.values.first
      result == 1
    end
  end
end
