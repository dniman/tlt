namespace :payments do
  namespace :source do
    namespace :payments do

      task :update___object do |t|
        def object 
          Destination::SObjects.obj_id('DOCUMENTS_0401003A')
        end

        def query
          manager = Arel::SelectManager.new Database.source_engine
          manager.project(
            Source.payments[:id],
            Arel.sql("#{object}").as("___object"),
          )
          manager.from(Source.payments)
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update payments set 
              payments.___object = values_table.___object
            from payments
              join (
                #{ query }
              ) values_table(id, ___object) on values_table.id = payments.id
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
