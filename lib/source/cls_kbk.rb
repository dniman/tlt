module Source
  class ClsKbk
    def self.table
      Source.cls_kbk
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
