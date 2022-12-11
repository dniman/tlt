namespace :moving_operations do
  namespace :source do
    namespace :___moving_operations do

      task :update___link_key do |t|

        def query
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.mss_moves_key[:link],
            Destination.mss_moves_key[:row_id],
          ])
          manager.from(Destination.mss_moves_key)
        end

        begin
          Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___moving_operations set 
                ___moving_operations.___link_a = values_table.___link_a
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ___moving_operation.id = values_table.id
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
