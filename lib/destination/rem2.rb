module Destination
  class Rem2

    def self.table
      Destination.rem2
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
      sql
    end

    def self.delete_query(rows)
      deleted_key = rows.map(&:keys).flatten.uniq.first
      values = rows.map(&:values)
      manager = Arel::DeleteManager.new(Database.destination_engine)
      manager.from (table)
      manager.where(Arel::Nodes::In.new(table[deleted_key], values))
      manager.to_sql
    end
    
  end
end
