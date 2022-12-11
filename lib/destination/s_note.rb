module Destination
  class SNote

    def self.table
      Destination.s_note
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
    
    def self.task_exists?(name)
      query =
        table
        .project(Arel.star)
        .where(Destination.s_note[:value].eq(name)
          .and(Destination.s_note[:object].eq(COMPLETED_TASKS))
        )
      
      res = Destination.execute_query(query.to_sql)
      result = res.entries.size > 0 ? true : false
      res.do
      result
    end

    def self.task_insert(task_name, flag)
      condition =<<~SQL
        s_note.value = values_table.value
          and s_note.object = values_table.object
      SQL
      
      insert = [{
        code: flag,
        value: task_name,
        object: COMPLETED_TASKS,
        row_id: Arel.sql('newid()'),
      }]

      sql = insert_query(rows: insert, condition: condition)
      Destination.execute_query(sql).do
    end
    
  end
end
