namespace :dictionaries do
  namespace :mss_docs_roles_in_operations do
    namespace :source do
      namespace :___ids do

        task :update_link do |t|
          def query
            Destination.mss_docs_roles_in_operations
            .project(
              Destination.mss_docs_roles_in_operations[:link], 
              Destination.mss_docs_roles_in_operations[:name], 
            )
          end

          begin
            Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update ___ids set 
                  ___ids.link = values_table.link
                from ___ids
                  join docroles on docroles.id = ___ids.id and ___ids.table_id = #{ Source::Docroles.table_id }
                  join (#{values_list.to_sql}) values_table(#{columns.join(', ')}) on values_table.name = docroles.name
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
