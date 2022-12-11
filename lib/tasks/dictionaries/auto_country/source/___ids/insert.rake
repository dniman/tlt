namespace :dictionaries do
  namespace :auto_country do
    namespace :source do
      namespace :___ids do

        task :insert do |t|
          def query
            Source.___mss_dict_decommission_causes
            .project([
              Arel.sql("table_id = #{Source::MssDictDecommissionCauses.table_id}"),
              Source.___mss_dict_decommission_causes[:id],
              Arel.sql("row_id = newid()")
            ])
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
