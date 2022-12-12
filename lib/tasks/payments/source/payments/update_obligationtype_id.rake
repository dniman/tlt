namespace :payments do
  namespace :source do
    namespace :payments do

      task :update_obligationtype_id do |t|
        def query
          manager = Arel::SelectManager.new Database.source_engine
          manager.project(
            Source.payments[:id],
            Source.___paycards[:obligationtype_id],
          )
          manager.from(Source.payments)
          manager.join(Source.___paycards).on(Source.___paycards[:moveset_id].eq(Source.payments[:movesets_id]))
          manager.where(
            Source.payments[:___paycard_id].eq(nil)
            .and(Source.___paycards[:obligationtype_id].not_eq(nil))
          )
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update payments set 
              payments.obligationtype_id = values_table.obligationtype_id
            from payments
              join(
                #{ query }
              ) values_table(id, obligationtype_id) on values_table.id = payments.id
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
