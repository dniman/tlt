namespace :objects do
  namespace :exright_intellprop do
    namespace :destination do
      namespace :mss_objects_app do
        namespace :link_param do
          namespace :amount do

            task :insert do |t|
              def link_type_query
                Destination.mss_objects_types 
                .project(Destination.mss_objects_types[:link])
                .where(Destination.mss_objects_types[:code].eq("EXRIGHT_INTELLPROP"))
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
                  Arel.sql("1").as("___amount"),
                  Source.___ids[:link],
                  Source.___ids[:link_type],
                ])
                .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
                .join(Source.___ids).on(Source.___ids[:id].eq(Source.objects[:id]).and(Source.___ids[:table_id].eq(Source::Objects.table_id)))
                .join(Source.property).on(Source.property[:objects_id].eq(Source.objects[:id]))
                .where(Source.___ids[:link_type].eq(link_type))
              end

              begin
                sql = ""
                insert = []
                link_param = Destination.execute_query(link_param_query('AMOUNT').to_sql).entries.first["link"]
                
                Source.execute_query(query.to_sql).each_slice(1000) do |rows|
                
                  rows.each do |row|
                    insert << {
                      link_up: row["link"],
                      link_param: link_param,
                      int: row["___amount"],
                    }
                  end
                  
                  condition =<<~SQL 
                    mss_objects_app.link_up = values_table.link_up 
                      and mss_objects_app.link_param = values_table.link_param
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
