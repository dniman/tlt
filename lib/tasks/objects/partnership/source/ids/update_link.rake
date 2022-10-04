namespace :objects do
  namespace :partnership do
    namespace :source do
      namespace :ids do

        task :update_link do |t|
          def query
            Destination.set_engine!
            query =
              Destination.mss_objects
              .project(
                Destination.mss_objects[:link], 
                Destination.mss_objects[:row_id], 
              )
              .join(Destination.mss_objects_types).on(Destination.mss_objects_types[:link].eq(Destination.mss_objects[:link_type]))
              .where(Destination.mss_objects_types[:code].eq('PARTNERSHIP'))
            query
          end

          begin
            sliced_rows = Destination.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update ids set 
                  ids.link = values_table.link
                from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                where ids.row_id = values_table.row_id  
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
