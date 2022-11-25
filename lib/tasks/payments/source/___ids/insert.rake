namespace :payments do
  namespace :source do
    namespace :___ids do

      task :insert do |t|
        def query
          Source.___paycardobjects
          .project([
            Arel.sql("table_id = #{Source::Paycardobjects.table_id}"),
            Source.___paycardobjects[:id],
            Arel.sql("row_id = newid()")
          ])
        end
        
        begin
          sql = ""
          insert = []
         
          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            rows.each do |row|
              insert << {
                table_id: row["table_id"],
                id: row["id"],
                row_id: row["row_id"],
              }
            end
            sql = Source::Ids.insert_query(rows: insert, condition: "___ids.id = values_table.id and ___ids.table_id = values_table.table_id")
            result = Source.execute_query(sql)
            result.do
            insert.clear
            sql.clear
          end

          Rake.info "Задача '#{ t }' успешно выполнена."
        rescue StandardError => e
          Rake.error "Ошибка при выполнении задачи '#{ t }' - #{e}."
          Rake.info "Текст запроса \"#{ sql }\""

          exit
        end
      end

    end
  end
end
