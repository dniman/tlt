namespace :moving_operation_objects do
  namespace :source do
    namespace :___moving_operation_objects do

      task :update___object_type_name do |t|

        def query
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.mss_objects_types[:link],
            Destination.mss_objects_types[:name].as("___object_type_name"),
          ])
          manager.from(Destination.mss_objects_types)
        end

        begin
          Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___moving_operation_objects set 
                ___moving_operation_objects.___object_type_name = values_table.___object_type_name
              from ___moving_operation_objects
                join ___ids on ___ids.id = ___moving_operation_objects.object_id
                left join (#{values_list.to_sql}) values_table(#{columns.join(', ')}) on values_table.link = ___ids.link_type
              where ___ids.table_id = #{ Source::Objects.table_id }
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
