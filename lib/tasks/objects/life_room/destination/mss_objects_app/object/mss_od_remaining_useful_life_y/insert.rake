namespace :objects do
  namespace :life_room do
    namespace :destination do
      namespace :mss_objects_app do
        namespace :object do
          namespace :mss_od_remaining_useful_life_y do

            task :insert do |t|
              def link_type_query
                Destination.set_engine!
                query = 
                  Destination.mss_objects_types 
                  .project(Destination.mss_objects_types[:link])
                  .where(Destination.mss_objects_types[:code].eq("LIFE_ROOM"))
              end
              
              def query
                link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

                Source.set_engine!
                
                Source.objects
                .project([
                  Source.ids[:link],
                  Source.ids[:link_type],
                ])
                .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
                .join(Source.ids).on(Source.ids[:id].eq(Source.objects[:id]).and(Source.ids[:table_id].eq(Source::Objects.table_id)))
                .join(Source.transport).on(Source.transport[:objects_id].eq(Source.objects[:id]))
                .where(Source.ids[:link_type].eq(link_type))
              end

              begin
                sql = ""
                insert = []
                
                sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
                sliced_rows.each do |rows|
                  rows.each do |row|
                    insert << {
                      link_up: row["link"],
                      int: 0,
                      object: Destination::SObjects.obj_id('MSS_OD_REMAINING_USEFUL_LIFE_Y'),
                    }
                  end
                  
                  condition =<<~SQL 
                    mss_objects_app.link_up = values_table.link_up 
                      and mss_objects_app.object = values_table.object
                  SQL

                  sql = Destination::MssObjectsApp.insert_query(rows: insert, condition: condition)
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