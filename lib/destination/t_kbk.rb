module Destination
  class TKbk 

    def self.t_kbk
      Destination.t_kbk
    end
    
    def self.insert_query(rows:, condition: nil)
      Destination.set_engine!

      manager = Arel::InsertManager.new
      manager.into(Destination.t_kbk)

      columns = rows.map(&:keys).uniq.flatten
      columns.each do |column|
        manager.columns << t_kbk[column]
      end

      manager.values = manager.create_values_list(rows.map(&:values))
      sql = manager.to_sql
      sql.sub!('VALUES', ' select distinct * from (VALUES')
      sql << ")as values_table(#{columns.join(',')})"
      
      if condition
        query =
          Destination.t_kbk
          .project(Arel.star)
          .where(Arel.sql(condition)).exists.not
        sql << " where #{query.to_sql}"
      end
      sql << " OPTION (QUERYTRACEON 8780)"
      sql
    end
    
    def self.update_query(row:, where:)
      manager = Arel::UpdateManager.new Database.destination_engine
      manager.table t_kbk
      manager.set([row.map(&:to_a).flatten])
      manager.where(where)
      manager.to_sql
    end

    def self.delete_query(links:, condition:)
      manager = Arel::DeleteManager.new(Database.destination_engine)
      manager.from (Destination.t_kbk)
      
      if condition
        manager.where(
          Arel::Nodes::In.new(Destination.t_kbk[:ref1],links)
          .and(Arel.sql(condition))
        )
      else
        manager.where(Arel::Nodes::In.new(Destination.t_kbk[:ref1],links))
      end
      manager.to_sql
    end
    
  end
end
