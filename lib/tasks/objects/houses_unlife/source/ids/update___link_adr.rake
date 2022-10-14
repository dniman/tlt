namespace :objects do
  namespace :houses_unlife do
    namespace :source do
      namespace :ids do

        task :update___link_adr do |t|
          def query
            Destination.mss_objects
            .project(
              Destination.mss_objects[:row_id], 
              Destination.mss_objects[:link_adr]
            )
            .join(Destination.mss_objects_types).on(Destination.mss_objects_types[:link].eq(Destination.mss_objects[:link_type]))
            .where(Destination.mss_objects_types[:code].eq('HOUSES_UNLIFE'))
          end

          begin
            sliced_rows = Destination.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update ids set 
                  ids.___link_adr = values_table.link_adr
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
