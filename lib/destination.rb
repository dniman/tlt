Dir[File.expand_path('../destination/*.rb', __FILE__)].each {|path| require path}

module Destination
  TABLES = [
    :mss_objects,
    :mss_objects_types,
    :mss_objects_dicts,
    :mss_objects_adr,
    :mss_adr,
    :mss_objects_params,
    :mss_objects_app
  ]

  class << self
    def execute_query(query)
      Database.execute_query(Database.destination, query)
    end

    def set_engine!
      Database.set_engine(Database.destination_engine)
    end
    
    def tables_instantiate!
      set_engine!

      TABLES.each do |table| 
        instance_eval "@#{table} ||= Arel::Table.new(:#{table})"
        define_singleton_method(table) do
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
