namespace :moving_operation_objects do
  namespace :source do
    namespace :___moving_operation_objects do

      task :update___is_excl_from_r do |t|

        def query
          ___is_excl_from_r = 
            Arel::Nodes::Case.new()
            .when(Source.___ids[:___code_group].eq('FROM_REESTR')).then(1)
            .else(0)

          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___moving_operation_objects[:id],
            ___is_excl_from_r.as("___is_excl_from_r"),
          ])
          manager.from(Source.___moving_operation_objects)
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update ___moving_operation_objects set 
              ___moving_operation_objects.___is_excl_from_r = values_table.___is_excl_from_r
            from ___moving_operation_objects
              join(
                #{ query }
              ) values_table(id, ___is_excl_from_r) on values_table.id = ___moving_operation_objects.id
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
