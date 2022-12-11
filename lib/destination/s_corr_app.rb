module Destination
  class SCorrApp

    def self.s_corr_app
      Destination.s_corr_app
    end
    
    def self.insert_query(rows:, condition: nil)
      manager = Arel::InsertManager.new
      manager.into(Destination.s_corr_app)

      columns = rows.map(&:keys).uniq.flatten
      columns.each do |column|
        manager.columns << s_corr_app[column]
      end

      manager.values = manager.create_values_list(rows.map(&:values))
      sql = manager.to_sql
      sql.sub!('VALUES', ' select distinct * from (VALUES')
      sql << ")as values_table(#{columns.join(',')})"
      
      if condition
        query =
          Destination.s_corr_app
          .project(Arel.star)
          .where(Arel.sql(condition)).exists.not
        sql << " where #{query.to_sql}"
      end
      sql << " OPTION (QUERYTRACEON 8780)"
      sql
    end
    
    def self.delete_query(links:, condition: nil)
      manager = Arel::DeleteManager.new(Database.destination_engine)
      manager.from (Destination.s_corr_app)
      if condition
        manager.where(
          Arel::Nodes::In.new(Destination.s_corr_app[:link_up], links)
          .and(Arel.sql(condition))
        )
      else
        manager.where(Arel::Nodes::In.new(Destination.s_corr_app[:link_up], links))
      end
      manager.to_sql
    end
    
  end
end
