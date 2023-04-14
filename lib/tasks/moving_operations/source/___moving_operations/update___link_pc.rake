namespace :moving_operations do
  namespace :source do
    namespace :___moving_operations do

      task :update___link_pc do |t|

        def query
          ___ids2 = Source.___ids.alias("___ids2")

          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___ids[:id],
            ___ids2[:link].as("___link_pc"),
          ])
          manager.from(Source.___moving_operations)
          manager.join(Source.___ids).on(
            Source.___ids[:id].eq(Source.___moving_operations[:id])
            .and(Source.___ids[:table_id].eq(Source::MovingOperations.table_id))
          )
          manager.join(Source.___paycards).on(
            Source.___paycards[:___agreement_id].eq(Source.___moving_operations[:___agreement_id])
            .and(Source.___paycards[:moveperiod_id].eq(Source.___moving_operations[:moveperiod_id]))
          )
          manager.join(___ids2).on(
            ___ids2[:id].eq(Source.___paycards[:id])
            .and(___ids2[:table_id].eq(Source::Paycards.table_id))
          )
          manager.where(Source.___paycards[:___move_type_name].not_eq(nil))
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update ___moving_operations set 
              ___moving_operations.___link_pc = values_table.___link_pc
            from ___moving_operations
              join(
                #{ query }
              ) values_table(id, ___link_pc) on values_table.id = ___moving_operations.id
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
