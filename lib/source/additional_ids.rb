module Source
  class AdditionalIds
    def self.additional_ids
      Source.additional_ids
    end
    
    def self.insert_query(rows:, condition: nil)
      Source.set_engine!
      manager = Arel::InsertManager.new
      manager.into(additional_ids)

      columns = rows.map(&:keys).uniq.flatten
      columns.each do |column|
        manager.columns << ids[column]
      end

      manager.values = manager.create_values_list(rows.map(&:values))
      sql = manager.to_sql
      sql.sub!('VALUES', ' select * from (VALUES')
      sql << ")as values_table(#{columns.join(',')})"
      
      if condition
        query =
         ids 
          .project(Arel.star)
          .where(Arel.sql(condition)).exists.not
        sql << " where #{query.to_sql}"
      end
      sql
    end

    def self.update_query(row:)
      manager = Arel::UpdateManager.new Database.source_engine
      manager.table(additional_ids)
      manager.set([row.map(&:to_a).flatten])
      manager.to_sql
    end
  end

end
