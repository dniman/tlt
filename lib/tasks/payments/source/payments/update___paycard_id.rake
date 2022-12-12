namespace :payments do
  namespace :source do
    namespace :payments do

      task :update___paycard_id do |t|
        def query
          manager = Arel::SelectManager.new Database.source_engine
          manager.project(
            Source.payments[:id],
            Source.___paycards[:id].as("___paycard_id"),
          )
          manager.from(Source.payments)
          manager.join(Source.___paycards).on(
            Source.___paycards[:moveset_id].eq(Source.payments[:movesets_id])
            .and(Source.___paycards[:obligationtype_id].eq(Source.payments[:obligationtype_id]))
            .and(Source.___paycards[:prev_moveperiod_id].eq(nil))
          )
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update payments set 
              payments.___paycard_id = values_table.___paycard_id
            from payments
              join(
                #{ query }
              ) values_table(id, ___paycard_id) on values_table.id = payments.id
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
