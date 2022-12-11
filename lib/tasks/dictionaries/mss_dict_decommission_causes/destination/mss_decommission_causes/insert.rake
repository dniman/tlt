namespace :dictionaries do
  namespace :mss_dict_decommission_causes do
    namespace :destination do
      namespace :mss_decommission_causes do

        task :insert do |t|
          def query
            Source.___mss_dict_decommission_causes
            .project([
              Source.___mss_dict_decommission_causes[:name],
              Source.___ids[:row_id],
            ])
            .join(Source.___ids).on(
              Source.___ids[:id].eq(Source.___mss_dict_decommission_causes[:id])
              .and(Source.___ids[:table_id].eq(Source::MssDictDecommissionCauses.table_id))
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
                mss_decommission_causes.row_id = values_table.row_id
              SQL

              sql = Destination::MssDecommissionCauses.insert_query(rows: insert, condition: condition)
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
