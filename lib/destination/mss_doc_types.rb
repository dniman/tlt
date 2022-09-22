module Destination
  class MssDocTypes

    def self.mss_doc_types
      Destination.mss_doc_types
    end
    
    def self.insert_query(rows:, condition: nil)
      Destination.set_engine!
      manager = Arel::InsertManager.new
      manager.into(Destination.mss_doc_types)

      columns = rows.map(&:keys).uniq.flatten
      columns.each do |column|
        manager.columns << mss_doc_types[column]
      end

      manager.values = manager.create_values_list(rows.map(&:values))
      sql = manager.to_sql
      sql.sub!('VALUES', ' select * from (VALUES')
      sql << ")as values_table(#{columns.join(',')})"
      
      if condition
        query =
          Destination.mss_doc_types
          .project(Arel.star)
          .where(Arel.sql(condition)).exists.not
        sql << " where #{query.to_sql}"
      end
      sql
    end
  end
end
