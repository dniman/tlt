namespace :dictionaries do
  namespace :mss_docs_roles_in_operations do
    namespace :destination do
      namespace :mss_docs_roles_in_operations do

        task :insert do |t|
          def query
            Source.docroles
            .project([
              Source.docroles[:name],
              Source.___ids[:row_id],
            ])
            .join(Source.___ids).on(
              Source.___ids[:id].eq(Source.docroles[:id])
              .and(Source.___ids[:table_id].eq(Source::Docroles.table_id))
            )
          end

          begin
            sql = ""
            insert = []
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
              rows.each do |row|
                insert << {
                  name: row['name'],
                  row_id: row["row_id"],
                }
              end

              condition =<<~SQL
                mss_docs_roles_in_operations.name = values_table.name
              SQL

              sql = Destination::MssDocsRolesInOperations.insert_query(rows: insert, condition: condition)
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
