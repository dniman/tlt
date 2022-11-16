namespace :paycards do
  namespace :source do
    namespace :___ids do

      task :insert do |t|
        def query1
          Source.___paycards
          .project([
            Arel.sql("table_id = #{Source::Paycards.table_id}"),
            Source.___paycards[:id],
            Arel.sql("row_id = newid()")
          ])
          .where(Source.___paycards[:prev_moveperiod_id].eq(nil))
        end
        
        def query2
          Source.___paycards
          .project([
            Arel.sql("table_id = #{Source::Paycards.table_id}"),
            Source.___paycards[:id],
            Arel.sql("row_id = newid()")
          ])
          .where(Source.___paycards[:prev_moveperiod_id].not_eq(nil))
        end

        begin
          sql = ""
          insert = []
         
          [query1, query2].each do |query|
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
