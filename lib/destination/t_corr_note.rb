module Destination
  class TCorrNote

    def self.table
      Destination.t_corr_note
    end
    
    def self.insert_query(rows:, condition: nil)
      Destination.set_engine!
      manager = Arel::InsertManager.new
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
    
    def self.delete_query(links:, condition: nil)
      Destination.set_engine!
     
      manager = Arel::DeleteManager.new(Database.destination_engine)
      manager.from(table)
      if condition
        manager.where(
          Arel::Nodes::In.new(table[:corr],links)
          .and(Arel.sql(condition))
        )
      else
        manager.where(Arel::Nodes::In.new(table[:corr],links))
      end
      manager.to_sql
    end
    
  end
end
