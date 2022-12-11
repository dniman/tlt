namespace :dictionaries do
  namespace :dictionary_nazn_rent do
    namespace :destination do
      namespace :s_nazn do

        task :insert do |t|
          def query
            Source.func_using
            .project([
              Source.func_using[:code],
              Source.func_using[:name],
              Source.___ids[:row_id],
            ])
            .join(Source.___ids).on(
              Source.___ids[:id].eq(Source.func_using[:id])
              .and(Source.___ids[:table_id].eq(Source::FuncUsing.table_id))
            )
          end

          begin
            sql = ""
            insert = []
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              rows.each do |row|
                insert << {
                  code: row['code'].nil? ? nil : row['code']&.strip,
                  name: row['name'].nil? ? nil : row['name']&.strip,
                  link_mo: Destination.link_mo,
                  row_id: row["row_id"],
                }
              end

              condition =<<~SQL
                s_nazn.row_id = values_table.row_id
              SQL

              sql = Destination::SNazn.insert_query(rows: insert, condition: condition)
              result = Destination.execute_query(sql)
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
end
