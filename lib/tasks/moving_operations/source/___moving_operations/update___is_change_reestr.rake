namespace :moving_operations do
  namespace :source do
    namespace :___moving_operations do

      task :update___is_change_reestr do |t|

        def query
          ___is_change_reestr = 
            Arel::Nodes::Case.new()
            .when(Source.___ids[:___code_group].eq('TO_REESTR')).then(1)
            .else(0)

          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___ids[:id],
            ___is_change_reestr.as("___is_change_reestr"),
          ])
          manager.from(Source.___ids)
          manager.where(Source.___ids[:table_id].eq(Source::MovingOperations.table_id))
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update ___moving_operations set 
              ___moving_operations.___is_change_reestr = values_table.___is_change_reestr
            from ___moving_operations
              join(
                #{ query }
              ) values_table(id, ___is_change_reestr) on values_table.id = ___moving_operations.id
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
