module Destination
  class MssViwOcvalMoRef

    def self.mss_viw_ocval_mo_ref
      Destination.mss_viw_ocval_mo_ref
    end
    
    def self.insert_query(rows:, condition: nil)
      Destination.set_engine!
      manager = Arel::InsertManager.new
      manager.into(Destination.mss_viw_ocval_mo_ref)

      columns = rows.map(&:keys).uniq.flatten
      columns.each do |column|
        manager.columns << mss_viw_ocval_mo_ref[column]
      end

      manager.values = manager.create_values_list(rows.map(&:values))
      sql = manager.to_sql
      sql.sub!('VALUES', ' select * from (VALUES')
      sql << ")as values_table(#{columns.join(',')})"
      
      if condition
        query =
          Destination.mss_viw_ocval_mo_ref
          .project(Arel.star)
          .where(Arel.sql(condition)).exists.not
        sql << " where #{query.to_sql}"
      end
      sql
    end
  end
end
