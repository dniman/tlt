namespace :import do
  namespace :unlife_room do
    namespace :destination do
      namespace :mss_objects_dicts do
        namespace :object do
          namespace :dictionary_land_kvartals do
            task :insert do |t|
              def query
                Destination.set_engine!
                
                query = 
                  Destination.mss_objects
                  .project([
                    Destination.mss_objects[:___cad_quorter]
                  ])
                  .distinct
                  .join(Destination.mss_objects_types, Arel::Nodes::OuterJoin).on(Destination.mss_objects_types[:link].eq(Destination.mss_objects[:link_type]))
                  .where(Destination.mss_objects_types[:code].eq("UNLIFE_ROOM"))
              end

              begin
                sql = ""
                insert = []
                sliced_rows = Destination.execute_query(query.to_sql).each_slice(1000).to_a
                sliced_rows.each do |rows|
                  rows.each do |row|
                    insert << {
                      code: row["___cad_quorter"]&.strip,
                      link_mo: Destination.link_mo,
                      object: Destination::MssObjectsDicts::DICTIONARY_LAND_KVARTALS,
                      row_id: Arel.sql('newid()'),
                    }
                  end
                  condition =<<~SQL
                    mss_objects_dicts.code = values_table.code 
                      and mss_objects_dicts.link_mo = values_table.link_mo
                      and mss_objects_dicts.object = values_table.object
                  SQL
                  sql = Destination::MssObjectsDicts.insert_query(rows: insert, condition: condition)
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
  end
end
