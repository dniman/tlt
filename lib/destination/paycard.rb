module Destination
  class Paycard

    def self.table
      Destination.paycard
    end
    
    def self.insert_query(rows:, condition: nil)
      manager = Arel::InsertManager.new Database.destination_engine
      manager.into(table)

      columns = rows.map(&:keys).uniq.flatten
      columns.each do |column|
        manager.columns << table[column]
      end
      
      manager.values = manager.create_values_list(rows.map(&:values))
      sql = manager.to_sql
      sql.sub!('VALUES', ' select distinct * from (VALUES')
      sql << ")as values_table(#{columns.join(',')})"
      
      if condition
        query =
          table
          .project(Arel.star)
          .where(Arel.sql(condition)).exists.not
        sql << " where #{query.to_sql}"
      end
      sql << " OPTION (QUERYTRACEON 8780)"
      sql
    end
    
    def self.insert_query2(rows:, condition: nil)
      columns = rows.map(&:keys).uniq.flatten
      values = rows.map(&:values)
      value_list = Arel::Nodes::ValuesList.new(values).to_sql
      column_list = columns.join(', ')
     
      where = 
        begin
          if condition
            query =
              table
              .project(Arel.star)
              .where(Arel.sql(condition)).exists.not
            " where #{query.to_sql}"
          else 
            ""
          end
        end

      sql =<<~sql 
        if object_id('tempdb..#temp_table') is not null drop table #temp_table
        select * into #temp_table from (#{value_list}) as values_table (#{column_list})
        insert into #{table.name}(#{column_list})
        select #{column_list}
        from #temp_table
        #{where}
        drop table #temp_table
      sql
      
    end
    
    def self.delete_query(links:)
      manager = Arel::DeleteManager.new(Database.destination_engine)
      manager.from (table)
      manager.where(Arel::Nodes::In.new(table[:link], links))
      manager.to_sql
    end
    
  end
end
