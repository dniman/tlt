module Source
  class Charges

    def self.table
      Source.charges
    end
    
    def self.table_id
      @table_id ||= begin
        sql = <<~SQL
          select object_id('#{ table.name }')
        SQL

        Source.execute_query(sql).entries.first.values.first
      end
    end

  end
end
