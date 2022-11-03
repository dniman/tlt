namespace :dictionaries do
  namespace :kbk do
    namespace :destination do
      namespace :s_kbk do
        namespace :dictionary_kbk_inc do

          task :insert do |t|
            def query
              Source.cls_kbk
              .project([
                Source.cls_kbk[:name],
                Source.___ids[:row_id],
              ])
              .join(Source.___ids).on(
                Source.___ids[:id].eq(Source.cls_kbk[:id])
                .and(Source.___ids[:table_id].eq(Source::ClsKbk.table_id))
              )
            end

            begin
              sql = ""
              insert = []
              index = 1
              
              sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
              sliced_rows.each do |rows|
                rows.each do |row|
                  insert << {
                    code: row["name"].strip,
                    object: Destination::SKbk::DICTIONARY_KBK_INC,
                    row_id: row["row_id"],
                  }
                end
              end

              condition =<<~SQL
                s_kbk.code = values_table.code
                  and s_kbk.object = #{ Destination::SKbk::DICTIONARY_KBK_INC }
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
