namespace :objects do
  namespace :unfinished do
    namespace :source do
      namespace :states do
        
        task :update___link_state do |t|
          def link_type_query
            Destination.mss_objects_types 
            .project(Destination.mss_objects_types[:link])
            .where(Destination.mss_objects_types[:code].eq("UNFINISHED"))
          end

          def link_param_query(code)
            Destination.mss_objects_params
            .project(Destination.mss_objects_params[:link])
            .where(Destination.mss_objects_params[:code].eq(code))
          end

          def query
            link_param = Destination.execute_query(link_param_query('STATE').to_sql).entries.first["link"]

            Destination.mss_objects_dicts
            .project(
              Destination.mss_objects_dicts[:name], 
              Destination.mss_objects_dicts[:link].as("link_state")
            )
            .where(Destination.mss_objects_dicts[:link_dict].eq(link_param))
          end

          begin
            link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

            Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update states set 
                  states.___link_state = values_table.link_state
                from states 
                  join statetypes on statetypes.id = states.statetypes_id
                  join ___ids on ___ids.id = states.objects_id and ___ids.table_id = #{ Source::Objects.table_id }
                  left join (#{values_list.to_sql}) values_table(#{columns.join(', ')}) on values_table.name = ltrim(rtrim(statetypes.name))  
                where ___ids.link_type = #{ link_type }
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
