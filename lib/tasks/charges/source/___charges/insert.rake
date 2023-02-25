namespace :charges do
  namespace :source do
    namespace :___charges do

      task :insert do |t|

        def query 
            
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Source.charges[:id].as("charges_id"),
            Source.payments_plan[:id].as("payments_plan_id"),
          ])
          manager.distinct
          manager.from(Source.charges)
          manager.join(Source.payments_plan, Arel::Nodes::OuterJoin).on(Source.payments_plan[:charges_id].eq(Source.charges[:id]))

          source = Arel::Nodes::JoinSource.new(manager,[])

          insert_manager = Arel::InsertManager.new Database.source_engine
          insert_manager.columns << Source.___charges[:charges_id] 
          insert_manager.columns << Source.___charges[:payments_plan_id]
          insert_manager.into(Source.___charges)
          insert_manager.select(source)
          insert_manager.to_sql
        end
        
        begin
          Source.execute_query(query).do

          Rake.info "Задача '#{ t }' успешно выполнена."
        rescue StandardError => e
          Rake.error "Ошибка при выполнении задачи '#{ t }' - #{e}."
          Rake.info "Текст запроса \"#{ query }\""
          exit
        end
      end

    end
  end
end
