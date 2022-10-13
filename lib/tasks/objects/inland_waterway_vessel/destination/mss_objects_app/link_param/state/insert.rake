namespace :objects do
  namespace :inland_waterway_vessel do
    namespace :destination do
      namespace :mss_objects_app do
        namespace :link_param do
          namespace :state do

            task :insert do |t|
              def link_type_query
                Destination.set_engine!
                query = 
                  Destination.mss_objects_types 
                  .project(Destination.mss_objects_types[:link])
                  .where(Destination.mss_objects_types[:code].eq("INLAND_WATERWAY_VESSEL"))
              end
              
              def link_param_query(code)
                Destination.set_engine!
                query = 
                  Destination.mss_objects_params
                  .project(Destination.mss_objects_params[:link])
                  .where(Destination.mss_objects_params[:code].eq(code))
              end

              def query
                link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

                Source.set_engine!
                aliased_table = Source.states.alias('aliased_table')

                manager = Arel::SelectManager.new(Database.source_engine)
                manager.project(aliased_table[:___link_state])
                manager.from(aliased_table)
                manager.where(
                  aliased_table[:objects_id].eq(Source.ids[:id])
                    .and(Source.ids[:table_id].eq(Source::Objects.table_id))
                    .and(aliased_table[:calcdate].eq(Source.states[:calcdate]))
                )
                manager.order(aliased_table[:___link_state].desc)
                manager.take(1)


                Source.ids
                .project([
                  Source.ids[:link],
                  manager.as("___link_state"),
                  Source.states[:calcdate],
                ])
                .join(Source.states, Arel::Nodes::OuterJoin)
                  .on(Source.states[:objects_id].eq(Source.ids[:id])
                    .and(Source.ids[:table_id].eq(Source::Objects.table_id))
                  )
                .where(Source.ids[:link_type].eq(link_type)
                  .and(Source.states[:___link_state].not_eq(nil))
                )
                .group(Source.ids[:link], Source.ids[:id], Source.ids[:table_id], Source.states[:calcdate])
              end

              begin
                sql = ""
                insert = []
                link_param = Destination.execute_query(link_param_query('STATE').to_sql).entries.first["link"]
                
                sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
                sliced_rows.each do |rows|
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
