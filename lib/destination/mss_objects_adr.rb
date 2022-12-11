module Destination
  class MssObjectsAdr
    def self.mss_objects_adr
      Destination.mss_objects_adr
    end

    def self.insert_query(rows:, condition: nil)
      Destination.set_engine!
      manager = Arel::InsertManager.new
      manager.into(Destination.mss_objects_adr)

      columns = rows.map(&:keys).uniq.flatten
      columns.each do |column|
        manager.columns << mss_objects_adr[column]
      end

      manager.values = manager.create_values_list(rows.map(&:values))
      sql = manager.to_sql
      sql.sub!('VALUES', ' select distinct * from (VALUES')
      sql << ")as values_table(#{columns.join(',')})"
      
      if condition
        query =
          Destination.mss_objects_adr
          .project(Arel.star)
          .where(Arel.sql(condition)).exists.not
        sql << " where #{query.to_sql}"
      end
      sql << " OPTION (QUERYTRACEON 8780)"
      sql
    end
  end

end
