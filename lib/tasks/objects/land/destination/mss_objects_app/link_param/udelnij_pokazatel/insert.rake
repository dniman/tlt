namespace :objects do
  namespace :land do
    namespace :destination do
      namespace :mss_objects_app do
        namespace :link_param do
          namespace :udelnij_pokazatel do

            task :insert do |t|
              def link_type_query
                Destination.mss_objects_types 
                .project(Destination.mss_objects_types[:link])
                .where(Destination.mss_objects_types[:code].eq("LAND"))
              end
              
              def link_param_query(code)
                Destination.mss_objects_params
                .project(Destination.mss_objects_params[:link])
                .where(Destination.mss_objects_params[:code].eq(code))
              end

              def query
                link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

                Source.objects
                .project([
                  Source.states[:kadastr_cost],
                  Source.states[:calcdate],
                  Source.___ids[:link_type],
                  Source.___ids[:link] 
                ])
                .distinct
                .join(Source.___ids).on(Source.___ids[:id].eq(Source.objects[:id]).and(Source.___ids[:table_id].eq(Source::Objects.table_id)))
                .join(Source.states).on(Source.states[:objects_id].eq(Source.objects[:id]))
                .where(Source.___ids[:link_type].eq(link_type)
                  .and(Source.states[:kadastr_cost].not_eq(nil))
                )
              end

              begin
                sql = ""
                insert = []
                link_param = Destination.execute_query(link_param_query('UDELNIJ_POKAZATEL').to_sql).entries.first["link"]
                
                sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
                sliced_rows.each do |rows|
                  rows.each do |row|
                    insert << {
                      link_up: row["link"],
                      link_param: link_param,
                      numeric: row["kadastr_cost"],
                      real_date: row["calcdate"].strftime("%Y%m%d")
                    }
                  end
                  
                  condition =<<~SQL
                    mss_objects_app.link_up = values_table.link_up 
                      and mss_objects_app.link_param = values_table.link_param
                      and mss_objects_app.numeric = values_table.numeric
                      and mss_objects_app.real_date = values_table.real_date
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
