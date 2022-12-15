namespace :moving_operation_objects do
  namespace :source do
    namespace :___moving_operation_objects do

      task :update___is_change_reestr do |t|

        def query
          ___is_change_reestr = 
            Arel::Nodes::Case.new()
            .when(Source.___moving_operation_objects[:___code_group].eq('TO_REESTR')).then(1)
            .when(
              Source.___moving_operation_objects[:___code_group].eq('OWN')
              .and(Source.___moving_operations[:client_id].eq(5100))
            ).then(1)
            .else(0)

          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___moving_operation_objects[:id],
            ___is_change_reestr.as("___is_change_reestr"),
          ])
          manager.from(Source.___moving_operation_objects)
          manager.join(Source.___moving_operations).on(Source.___moving_operations[:id].eq(Source.___moving_operation_objects[:___moving_operation_id]))
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update ___moving_operation_objects set 
              ___moving_operation_objects.___is_change_reestr = values_table.___is_change_reestr
            from ___moving_operation_objects
              join(
                #{ query }
              ) values_table(id, ___is_change_reestr) on values_table.id = ___moving_operation_objects.id
          SQL

          Source.execute_query(sql).do
          
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
