namespace :dictionaries do
  namespace :kbk do
    namespace:source do
      namespace :___ids do

        task :insert do |t|

          def query
            Source.cls_kbk
            .project([
              Arel.sql("table_id = #{Source::ClsKbk.table_id}"),
              Source.cls_kbk[:id],
              Arel.sql("row_id = newid()")
            ])
            .where(Source.cls_kbk[:name].not_eq(nil))
         end

          begin
            sql = ""
            insert = []
            
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            
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

            Source.execute_query(sql).do
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
end
