module Source
  class PaymentsPlan
    def self.table
      Source.payments_plan
    end
    
    def self.table_id
      @table_id ||= begin
        sql = <<~SQL
          select object_id('#{ table.name }')
        SQL

        Source.execute_query(sql).entries.first.values.first
      end
    end
    
    def self.insert_query(rows:, condition: nil)
      manager = Arel::InsertManager.new
      manager.into(table)

      columns = rows.map(&:keys).uniq.flatten
      columns.each do |column|
        manager.columns << table[column]
      end

      manager.values = manager.create_values_list(rows.map(&:values))
      sql = manager.to_sql
      sql.sub!('VALUES', ' select * from (VALUES')
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

    def self.update_query(row:)
      manager = Arel::UpdateManager.new Database.source_engine
      manager.table(table)
      manager.set([row.map(&:to_a).flatten])
      manager.to_sql
    end
  end

end
