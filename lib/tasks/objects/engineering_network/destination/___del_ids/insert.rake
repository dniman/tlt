namespace :objects do
  namespace :engineering_network do
    namespace :destination do
      namespace :___del_ids do

        task :insert do |t|
          def link_type_query
            Destination.mss_objects_types 
            .project(Destination.mss_objects_types[:link])
            .where(Destination.mss_objects_types[:code].eq("ENGINEERING_NETWORK"))
          end

          def query
            link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

            Source.___ids
            .project([
              Source.___ids[:table_id],
              Source.___ids[:link],
              Source.___ids[:row_id],
            ])
            .where(
              Source.___ids[:table_id].eq(Source::Objects.table_id)
              .and(Source.___ids[:link_type].eq(link_type))
            )
          end
          
          begin
            sql = ""
            insert = []
           
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
              rows.each do |row|
                insert << {
                  table_id: row["table_id"],
                  link: row["link"],
                  row_id: row["row_id"],
                }
              end

              sql = Destination::DelIds.insert_query(rows: insert)
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
