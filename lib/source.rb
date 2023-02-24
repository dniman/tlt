Dir[File.expand_path('../source/*.rb', __FILE__)].each {|path| require path}

module Source
  TABLES = [
    :___ids,
    :objects,
    :objtypes,
    :grounds,
    :address,
    :countries,
    :regions,
    :provincearea,
    :townnames,
    :streets,
    :townarea,
    :microarea,
    :buildings,
    :buildtypes,
    :grounds_noknum_own,
    :groundtypes,
    :gr_fact_release,
    :grounds_release,
    :gr_rel_groups,
    :target_doc,
    :grounds_funk_using,
    :spr_zhkh_vid,
    :enginf,
    :enginftypes,
    :buildmaterials,
    :monumenttypes,
    :road_use,
    :road_category,
    :road_classes,
    :infgroups,
    :clients,
    :client_types,
    :privates,
    :organisations,
    :documents,
    :doctypes,
    :cls_kbk,
    :additional____ids,
    :unconstr,
    :property,
    :propnames,
    :propgroups,
    :propsections,
    :transport,
    :objshares,
    :sharetypes,
    :transptype,
    :brandnames,
    :colors,
    :engtype,
    :manufacturers,
    :intellectualtypes,
    :intellect,
    :states,
    :statetypes,
    :links_grounds_buildings,
    :links_grounds_enginf,
    :links_grounds_unconstr,
    :docset_members,
    :movesets,
    :movetype,
    :___agreements,
    :docroles,
    :moveperiods,
    :moveitems,
    :transferbasis,
    :per_dog,
    :docstate,
    :registeredusers,
    :docendprich,
    :obligations,
    :obligationtype,
    :paydocs,
    :___paycards,
    :func_using,
    :___paycardobjects,
    :objectusing,
    :usingprupose,
    :charges,
    :payments,
    :ifs_assigned_payments,
    :ifs_payments,
    :___moving_operations,
    :___mss_movescausesb_di,
    :___mss_dict_decommission_causes,
    :___moving_operation_objects,
    :privdoctypes,
    :privufms,
    :___client_banks,
    :sections,
    :___industries,
    :orgforms,
    :industsubj,
    :___main_otrs,
    :___kat_pols,
    :clientcategory,
    :company,
    :reg_operator_kod_erin,
    :payments_plan,
  ]
  
  class << self
    def execute_query(query)
      connection = Database.source.sqlsent? ? Database.source2 : Database.source
      Database.execute_query(connection, query)
    end

    def set_engine!
      Database.set_engine(Database.source_engine)
    end

    def engine_owner?
      Arel::Table.engine == Database.source_engine
    end
    
    def tables_instantiate!
      TABLES.each do |table| 
        instance_eval "@#{table} ||= Arel::Table.new(:#{table})"
        define_singleton_method(table) do
          set_engine! unless engine_owner?
          instance_variable_get("@#{table}")
        end
      end
    end

    def tables
      instance_variables
    end
    
    def table_exists?(name)
      sql =<<~SQL
        select case when object_id(N'[dbo].[#{ name }]') is null then 0 else 1 end
      SQL

      result = Source.execute_query(sql).entries.first.values.first
      result == 1
    end
    
  end
end

