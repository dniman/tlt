module Destination
  class SCorr

    def self.s_corr
      Destination.s_corr
    end
    
    def self.insert_query(rows:, condition: nil)
      Destination.set_engine!
      manager = Arel::InsertManager.new
      manager.into(Destination.s_corr)

      columns = rows.map(&:keys).uniq.flatten
      columns.each do |column|
        manager.columns << s_corr[column]
      end

      manager.values = manager.create_values_list(rows.map(&:values))
      sql = manager.to_sql
      sql.sub!('VALUES', ' select distinct * from (VALUES')
      sql << ")as values_table(#{columns.join(',')})"
      
      if condition
        query =
          Destination.s_corr
          .project(Arel.star)
          .where(Arel.sql(condition)).exists.not
        sql << " where #{query.to_sql}"
      end
      sql
    end

    def self.delete_query(links:)
      manager = Arel::DeleteManager.new(Database.destination_engine)
      manager.from (Destination.s_corr)
      manager.where(Arel::Nodes::In.new(Destination.s_corr[:link], links))
      manager.to_sql
    end
    
  end
end
