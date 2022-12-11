namespace :dictionaries do
  namespace :mss_dict_decommission_causes do
    namespace :source do
      namespace :___mss_dict_decommission_causes do
        
        task :insert do |t|
          def query
            Source.movesets
            .project([
              Source.transferbasis[:name]
            ])
            .distinct
            .join(Source.movetype).on(Source.movetype[:id].eq(Source.movesets[:movetype_id]))
            .join(Source.transferbasis).on(Source.transferbasis[:id].eq(Source.movesets[:transferbasis_id]))
            .where(
              Source.movetype[:name].in(['Списание', 'Ликвидация'])
              .and(Source.transferbasis[:name].not_eq('Списание'))
            )
          end
          
          begin
            sql = ""
            insert = []
           
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              rows.each do |row|
                insert << {
                  name: row["name"],
                }
              end
              sql = Source::MssDictDecommissionCauses.insert_query(rows: insert, condition: "___mss_dict_decommission_causes.name = values_table.name")
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
