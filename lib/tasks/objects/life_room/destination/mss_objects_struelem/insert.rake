namespace :objects do
  namespace :life_room do
    namespace :destination do
      namespace :mss_objects_struelem do

        task :insert do |t|
          def link_type_query(code)
            Destination.mss_objects_types 
            .project(Destination.mss_objects_types[:link])
            .where(Destination.mss_objects_types[:code].eq(code))
          end

          def query
            link_type = Destination.execute_query(link_type_query('LIFE_ROOM').to_sql).entries.first["link"]

            b = Source.buildings.alias("b")
            b1 = Source.buildings.alias("b1")
            o = Source.objects.alias("o")
            o1 = Source.objects.alias("o1")
            mo = Source.___ids.alias("mo")
            mo1 = Source.___ids.alias("mo1")
            
            manager = Arel::SelectManager.new(Database.source_engine)
            manager.project([
              Arel.sql("newid()").as("row_id"),
              mo1[:link].as("link_up"),
              mo[:link].as("link_elem"),
            ])
            manager.from(b)
            manager.join(b1).on(b1[:id].eq(b[:basebuilding]))
            manager.join(o).on(o[:id].eq(b[:objects_id]))
            manager.join(o1).on(o1[:id].eq(b1[:objects_id]))
            manager.join(mo).on(mo[:id].eq(o[:id]).and(mo[:table_id].eq(Source::Objects.table_id)))
            manager.join(mo1).on(mo1[:id].eq(o1[:id]).and(mo1[:table_id].eq(Source::Objects.table_id)))
            manager.where(mo1[:link_type].eq(link_type))
          end

          begin
            sql = ""
            insert = []
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              rows.each do |row|
                insert << {
                  row_id: row["row_id"],
                  link_up: row["link_up"],
                  link_elem: row["link_elem"],
                }
              end

              condition =<<~SQL
                mss_objects_struelem.link_up = values_table.link_up
                  and mss_objects_struelem.link_elem = values_table.link_elem
              SQL
              
              sql = Destination::MssObjectsStruelem.insert_query(rows: insert, condition: condition)
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
