module Destination
  class SKbkName

    def self.s_kbk_name
      Destination.s_kbk_name
    end
    
    def self.insert_query(rows:, condition: nil)
      Destination.set_engine!

      manager = Arel::InsertManager.new
      manager.into(Destination.s_kbk_name)

      columns = rows.map(&:keys).uniq.flatten
      columns.each do |column|
        manager.columns << s_kbk_name[column]
      end

      manager.values = manager.create_values_list(rows.map(&:values))
      sql = manager.to_sql
      sql.sub!('VALUES', ' select distinct * from (VALUES')
      sql << ")as values_table(#{columns.join(',')})"
      
      if condition
        query =
          Destination.s_kbk_name
          .project(Arel.star)
          .where(Arel.sql(condition)).exists.not
        sql << " where #{query.to_sql}"
      end
      sql << " OPTION (QUERYTRACEON 8780)"
      sql
    end

    def self.update_query(row:, where:)
      manager = Arel::UpdateManager.new Database.destination_engine
      manager.table s_kbk_name
      manager.set([row.map(&:to_a).flatten])
      manager.where(where)
      manager.to_sql
    end

    def self.delete_query(links:)
      manager = Arel::DeleteManager.new(Database.destination_engine)
      manager.from (Destination.s_kbk_name)
      manager.where(Arel::Nodes::In.new(Destination.s_kbk_name[:link_up],links))
      manager.to_sql
    end
    
  end
end
