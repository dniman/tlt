namespace :objects do
  namespace :transport do
    namespace :destination do
      namespace :mss_objects_app do
        namespace :link_param do
          namespace :state do

            task :insert do |t|
              def link_type_query
                Destination.mss_objects_types 
                .project(Destination.mss_objects_types[:link])
                .where(Destination.mss_objects_types[:code].eq("TRANSPORT"))
              end
              
              def link_param_query(code)
                Destination.mss_objects_params
                .project(Destination.mss_objects_params[:link])
                .where(Destination.mss_objects_params[:code].eq(code))
              end

              def query
                link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

                aliased_table = Source.states.alias('aliased_table')

                manager = Arel::SelectManager.new(Database.source_engine)
                manager.project(aliased_table[:___link_state])
                manager.from(aliased_table)
                manager.where(
                  aliased_table[:objects_id].eq(Source.___ids[:id])
                    .and(Source.___ids[:table_id].eq(Source::Objects.table_id))
                    .and(aliased_table[:calcdate].eq(Source.states[:calcdate]))
                )
                manager.order(aliased_table[:___link_state].desc)
                manager.take(1)


                Source.___ids
                .project([
                  Source.___ids[:link],
                  manager.as("___link_state"),
                  Source.states[:calcdate],
                ])
                .join(Source.states, Arel::Nodes::OuterJoin)
                  .on(Source.states[:objects_id].eq(Source.___ids[:id])
                    .and(Source.___ids[:table_id].eq(Source::Objects.table_id))
                  )
                .where(Source.___ids[:link_type].eq(link_type)
                  .and(Source.states[:___link_state].not_eq(nil))
                )
                .group(Source.___ids[:link], Source.___ids[:id], Source.___ids[:table_id], Source.states[:calcdate])
              end

              begin
                sql = ""
                insert = []
                link_param = Destination.execute_query(link_param_query('STATE').to_sql).entries.first["link"]
                
                Source.execute_query(query.to_sql).each_slice(1000) do |rows|
                
                  rows.each do |row|
                    insert << {
                      link_up: row["link"],
                      link_param: link_param,
                      link_dict: row["___link_state"],
                      real_date: row["calcdate"].strftime("%Y%m%d")
                    }
                  end
                  
                  condition = "
                    mss_objects_app.link_up = values_table.link_up 
                      and mss_objects_app.link_param = values_table.link_param
                      and mss_objects_app.real_date = values_table.real_date
                  "
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
