namespace :payments do
  namespace :source do
    namespace :payments do

      task :update___type do |t|
        def query
          manager = Arel::SelectManager.new Database.source_engine
          manager.project(
            Source.payments[:id],
            Arel.sql("1").as("___type"),
          )
          manager.from(Source.payments)
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update payments set 
              payments.___type = values_table.___type
            from payments
              join(
                #{ query }
              ) values_table(id, ___type) on values_table.id = payments.id
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
