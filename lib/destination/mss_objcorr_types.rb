module Destination
  class MssObjcorrTypes

    def self.mss_objcorr_types
      Destination.mss_objcorr_types
    end
    
    def self.insert_query(rows:, condition: nil)
      Destination.set_engine!
      manager = Arel::InsertManager.new
      manager.into(Destination.mss_objcorr_types)

      columns = rows.map(&:keys).uniq.flatten
      columns.each do |column|
        manager.columns << mss_objcorr_types[column]
      end

      manager.values = manager.create_values_list(rows.map(&:values))
      sql = manager.to_sql
      sql.sub!('VALUES', ' select * from (VALUES')
      sql << ")as values_table(#{columns.join(',')})"
      
      if condition
        query =
          Destination.mss_objcorr_types
          .project(Arel.star)
          .where(Arel.sql(condition)).exists.not
        sql << " where #{query.to_sql}"
      end
      sql << " OPTION (QUERYTRACEON 8780)"
      sql
    end
  end
end
