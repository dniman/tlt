namespace :objects do
  namespace :land do
    namespace :source do
      namespace :states do
        
        task :update___link_state do |t|
          def link_type_query
            Destination.set_engine!
            query = 
              Destination.mss_objects_types 
              .project(Destination.mss_objects_types[:link])
              .where(Destination.mss_objects_types[:code].eq("LAND"))
          end

          def link_param_query(code)
            Destination.set_engine!
            query = 
              Destination.mss_objects_params
              .project(Destination.mss_objects_params[:link])
              .where(Destination.mss_objects_params[:code].eq(code))
          end

          def query
            link_param = Destination.execute_query(link_param_query('STATE').to_sql).entries.first["link"]

            Destination.set_engine!
            
            Destination.mss_objects_dicts
            .project(
              Destination.mss_objects_dicts[:name], 
              Destination.mss_objects_dicts[:link].as("link_state")
            )
            .where(Destination.mss_objects_dicts[:link_dict].eq(link_param))
          end

          begin
            link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

            sliced_rows = Destination.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update states set 
                  states.___link_state = values_table.link_state
                from states 
                  join statetypes on statetypes.id = states.statetypes_id
                  join ids on ids.id = states.objects_id and ids.table_id = #{ Source::Objects.table_id }
                  left join (#{values_list.to_sql}) values_table(#{columns.join(', ')}) on values_table.name = ltrim(rtrim(statetypes.name))  
                where ids.link_type = #{ link_type }
              SQL
              result = Source.execute_query(sql)
              result.do
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
