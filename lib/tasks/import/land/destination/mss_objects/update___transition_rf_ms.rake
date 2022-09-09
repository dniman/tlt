namespace :import do
  namespace :land do
    namespace :destination do
      namespace :mss_objects do
        task :update___transition_rf_ms do |t|
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
            query = 
              Source.objects
              .project([
                Source.grounds[:in_transition],
                Source.ids[:link] 
              ])
              .join(Source.grounds).on(Source.grounds[:objects_id].eq(Source.objects[:id]))
              .join(Source.ids).on(Source.ids[:id].eq(Source.objects[:id]).and(Source.ids[:table_id].eq(Source::Objects.table_id)))
              .where(Source.ids[:link_type].eq(link_type))
          end

          begin
            update = []
            sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              rows.each do |row|
                update << {
                  link: row["link"],
                  ___transition_rf_ms: row["in_transition"]&.strip == 'Y' ? 'Да' : 'Нет'
                }
              end
              columns = update.map(&:keys).uniq.flatten 
              values_list = Arel::Nodes::ValuesList.new(update.map(&:values))
              
              sql = <<~SQL
                update mss_objects set 
                  mss_objects.___transition_rf_ms = values_table.___transition_rf_ms
                from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                where mss_objects.link = values_table.link
              SQL
              result = Destination.execute_query(sql)
              result.do
              update.clear
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
