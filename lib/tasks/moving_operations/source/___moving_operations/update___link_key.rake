namespace :moving_operations do
  namespace :source do
    namespace :___moving_operations do

      task :update___link_key do |t|

        def query
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.mss_moves_key[:link].as("___link_key"),
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
                ___moving_operations.___link_key = values_table.___link_key
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                join ___ids on ___ids.row_id = values_table.row_id
                join ___moving_operations on ___moving_operations.id = ___ids.id
              where table_id = #{ Source::MovingOperations.table_id }
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
