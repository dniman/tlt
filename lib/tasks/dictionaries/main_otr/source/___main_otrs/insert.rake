namespace :dictionaries do
  namespace :main_otr do
    namespace :source do
      namespace :___main_otrs do
        
        task :insert do |t|
          def query
            subquery = Arel::SelectManager.new Database.source_engine
            subquery.project(Arel.star)
            subquery.from(Source.___main_otrs)
            subquery.where(
              Source.___main_otrs[:name].eq(Source.industsubj[:name])
            )
             
            select_manager = Arel::SelectManager.new
            select_manager.project([
              Source.industsubj[:name],
            ])
            select_manager.distinct
            select_manager.from(Source.industsubj)
            select_manager.where(subquery.exists.not)
            
            source = Arel::Nodes::JoinSource.new(select_manager,[])

            insert_manager = Arel::InsertManager.new Database.source_engine
            insert_manager.columns << Source.___main_otrs[:name] 
            insert_manager.into(Source.___main_otrs)
            insert_manager.select(source)
            insert_manager.to_sql
          end
          
          begin
            Source.execute_query(query)

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
end
