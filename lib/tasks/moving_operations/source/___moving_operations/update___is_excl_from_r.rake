namespace :moving_operations do
  namespace :source do
    namespace :___moving_operations do

      task :update___is_excl_from_r do |t|

        def query
          ___is_excl_from_r = 
            Arel::Nodes::Case.new()
            .when(Source.___ids[:___code_group].eq('FROM_REESTR')).then(1)
            .else(0)

          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___ids[:id],
            ___is_excl_from_r.as("___is_excl_from_r"),
          ])
          manager.from(Source.___ids)
          manager.where(Source.___ids[:table_id].eq(Source::MovingOperations.table_id))
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update ___moving_operations set 
              ___moving_operations.___is_excl_from_r = values_table.___is_excl_from_r
            from ___moving_operations
              join(
                #{ query }
              ) values_table(id, ___is_excl_from_r) on values_table.id = ___moving_operations.id
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
