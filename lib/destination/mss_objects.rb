module Destination
  class MssObjects
    def self.mss_objects
      Destination.mss_objects
    end

    def self.insert_query(rows:, condition: nil)
      Destination.set_engine!
      manager = Arel::InsertManager.new
      manager.into(Destination.mss_objects)

      columns = rows.map(&:keys).uniq.flatten
      columns.each do |column|
        manager.columns << mss_objects[column]
      end

      manager.values = manager.create_values_list(rows.map(&:values))
      sql = manager.to_sql
      sql.sub!('VALUES', ' select * from (VALUES')
      sql << ")as values_table(#{columns.join(',')})"
      
      if condition
        query =
          Destination.mss_objects
          .project(Arel.star)
          .where(Arel.sql(condition)).exists.not
        sql << " where #{query.to_sql}"
      end
      sql
    end

    def self.update_query(row:, where:)
      manager = Arel::UpdateManager.new Database.destination_engine
      manager.table mss_objects
      manager.set([row.map(&:to_a).flatten])
      manager.where(where)
      manager.to_sql
    end
  end

end
