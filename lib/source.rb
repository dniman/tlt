#Dir.glob('source/*.rb').each { |r| require_relative r }
Dir[File.expand_path('../source/*.rb', __FILE__)].each {|path| require path}

module Source
  TABLES = [
    :ids,
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
    :groundtypes
  ]
  
  class << self
    def execute_query(query)
      Database.execute_query(Database.source, query)
    end

    def set_engine!
      Database.set_engine(Database.source_engine)
    end
    
    def tables_instantiate!
      set_engine!

      TABLES.each do |table| 
        instance_eval "@#{table} ||= Arel::Table.new(:#{table})"
        define_singleton_method(table) do
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

