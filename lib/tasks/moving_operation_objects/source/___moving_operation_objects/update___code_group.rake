namespace :moving_operation_objects do
  namespace :source do
    namespace :___moving_operation_objects do

      task :update___code_group do |t|

        def query
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.mss_v_moves_types[:link],
            Destination.mss_v_moves_types[:code_group].as("___code_group"),
          ])
          manager.from(Destination.mss_v_moves_types)
          manager.where(Destination.mss_v_moves_types[:code_group].not_eq(nil))
          manager.to_sql
        end

        begin
          sql = ""

          Destination.execute_query(query).each_slice(1000) do |rows|
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___moving_operation_objects set 
                ___moving_operation_objects.___code_group = values_table.___code_group
              from ___moving_operation_objects
                join ___moving_operations on ___moving_operations.id = ___moving_operation_objects.___moving_operation_id
                join ___ids on ___ids.id = ___moving_operations.id and ___ids.table_id = #{ Source::MovingOperations.table_id }
                left join(#{values_list.to_sql}) values_table(#{columns.join(', ')}) on values_table.link = ___ids.link_type
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
