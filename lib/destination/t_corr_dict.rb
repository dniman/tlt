module Destination
  class TCorrDict

    def self.t_corr_dict
      Destination.t_corr_dict
    end
    
    def self.insert_query(rows:, condition: nil)
      Destination.set_engine!
      manager = Arel::InsertManager.new
      manager.into(Destination.t_corr_dict)

      columns = rows.map(&:keys).uniq.flatten
      columns.each do |column|
        manager.columns << t_corr_dict[column]
      end

      manager.values = manager.create_values_list(rows.map(&:values))
      sql = manager.to_sql
      sql.sub!('VALUES', ' select distinct * from (VALUES')
      sql << ")as values_table(#{columns.join(',')})"
      
      if condition
        query =
          Destination.t_corr_dict
          .project(Arel.star)
          .where(Arel.sql(condition)).exists.not
        sql << " where #{query.to_sql}"
      end
      sql
    end
    
    def self.delete_query(links:)
      Destination.set_engine!
     
      manager = Arel::DeleteManager.new(Database.destination_engine)
      manager.from (Destination.t_corr_dict)
      manager.where(Arel::Nodes::In.new(Destination.t_corr_dict[:corr],links))
      manager.to_sql
    end
    
  end
end
