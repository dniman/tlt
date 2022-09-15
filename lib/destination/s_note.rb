module Destination
  class SNote

    def self.s_note
      Destination.s_note
    end
    
    def self.insert_query(rows:, condition: nil)
      Destination.set_engine!
      manager = Arel::InsertManager.new
      manager.into(Destination.s_note)

      columns = rows.map(&:keys).uniq.flatten
      columns.each do |column|
        manager.columns << s_note[column]
      end

      manager.values = manager.create_values_list(rows.map(&:values))
      sql = manager.to_sql
      sql.sub!('VALUES', ' select distinct * from (VALUES')
      sql << ")as values_table(#{columns.join(',')})"
      
      if condition
        query =
          Destination.s_note
          .project(Arel.star)
          .where(Arel.sql(condition)).exists.not
        sql << " where #{query.to_sql}"
      end
      sql
    end
    
    def self.task_exists?(name)
      query =
        Destination.s_note
          .project(Arel.star)
          .where(Destination.s_note[:value].eq(name)
            .and(Destination.s_note[:object].eq(COMPLETED_TASKS))
          )
      
      res = Destination.execute_query(query.to_sql)
      result = res.entries.size > 0 ? true : false
      res.do
      result
    end

    def self.task_insert(rows:)
      condition =<<~SQL
        s_note.value = values_table.value
          and s_note.object = values_table.object
      SQL
      sql = insert_query(rows: rows, condition: condition)
      Destination.execute_query(sql).do
    end
    
  end
end
