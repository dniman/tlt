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
  ]

  class << self
    def execute_query(query)
      Database.execute_query(Database.destination, query)
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
  end
end
