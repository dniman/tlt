namespace :dictionaries do
  namespace :kbk do
    namespace :destination do
      namespace :s_kbk do
        namespace :dictionary_item do

          task :insert do |t|
            def query
              Source.cls_kbk
              .project([
                Source.cls_kbk[:name],
              ])
              .where(Source.cls_kbk[:name].not_eq(nil))
            end

            begin
              sql = ""
              insert = []
              index = 1
              
              Source.execute_query(query.to_sql).each_slice(1000) do |rows|
              
                rows.each do |row|
                  insert << {
                    code: row["name"].strip[17,3],
                    object: Destination::SKbk::DICTIONARY_ITEM,
                    row_id: Arel.sql("newid()"),
                  }
                end
              end

              condition =<<~SQL
                s_kbk.code = values_table.code
                  and s_kbk.object = #{ Destination::SKbk::DICTIONARY_ITEM }
              SQL

              sql = Destination::SKbk.insert_query(rows: insert, condition: condition)
              result = Destination.execute_query(sql)
              result.do
              insert.clear
              sql.clear
              
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
end
