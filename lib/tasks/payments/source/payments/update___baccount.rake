namespace :payments do
  namespace :source do
    namespace :payments do

      task :update___baccount do |t|
        def query
          manager = Arel::SelectManager.new Database.source_engine
          manager.project(
            Source.payments[:id],
            Source.___paycards[:___account].as("___baccount"),
          )
          manager.from(Source.payments)
          manager.join(Source.___paycards).on(Source.___paycards[:id].eq(Source.payments[:___paycard_id]))
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update payments set 
              payments.___baccount = values_table.___baccount
            from payments
              join(
                #{ query }
              ) values_table(id, ___baccount) on values_table.id = payments.id
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
