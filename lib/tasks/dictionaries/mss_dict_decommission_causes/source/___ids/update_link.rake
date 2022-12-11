namespace :dictionaries do
  namespace :mss_dict_decommission_causes do
    namespace :source do
      namespace :___ids do

        task :update_link do |t|
          def query
            Destination.mss_decommission_causes
            .project(
              Destination.mss_decommission_causes[:link], 
              Destination.mss_decommission_causes[:row_id], 
            )
          end

          begin
            Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update ___ids set 
                  ___ids.link = values_table.link
                from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                where ___ids.row_id = values_table.row_id  
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
