namespace :objects do
  namespace :unlife_room do
    namespace :destination do
      namespace :mss_objects_app do
        namespace :soc_zn_obj do

          task :insert do |t|
            def link_type_query
              Destination.set_engine!
              query = 
                Destination.mss_objects_types 
                .project(Destination.mss_objects_types[:link])
                .where(Destination.mss_objects_types[:code].eq("UNLIFE_ROOM"))
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

              Destination.set_engine!
              query = 
                Destination.mss_objects
                .project([
                  Destination.mss_objects[:link],
                  Destination.mss_objects[:___link_soc_zn_obj],
                ])
                .join(Destination.mss_objects_types, Arel::Nodes::OuterJoin).on(Destination.mss_objects_types[:link].eq(Destination.mss_objects[:link_type]))
                .where(Destination.mss_objects[:link_type].eq(link_type)
                  .and(Destination.mss_objects[:___link_soc_zn_obj].not_eq(nil))
                )
            end

            begin
              sql = ""
              insert = []
              link_param = Destination.execute_query(link_param_query('SOC_ZN_OBJ').to_sql).entries.first["link"]
              
              sliced_rows = Destination.execute_query(query.to_sql).each_slice(1000).to_a
              sliced_rows.each do |rows|
                rows.each do |row|
                  insert << {
                    link_up: row["link"],
                    link_param: link_param,
                    link_dict: row["___link_soc_zn_obj"]
                  }
                end
                
                condition = "mss_objects_app.link_up = values_table.link_up and mss_objects_app.link_param = values_table.link_param"
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
