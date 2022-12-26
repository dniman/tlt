namespace :dictionaries do
  namespace :industry do
    namespace :source do
      namespace :___industries do
        
        task :insert do |t|
          def query
            subquery = Arel::SelectManager.new Database.source_engine
            subquery.project(Arel.star)
            subquery.from(Source.___industries)
            subquery.where(
              Source.___industries[:name].eq(Source.sections[:name])
            )
             
            select_manager = Arel::SelectManager.new
            select_manager.project([
              Source.sections[:name],
            ])
            select_manager.distinct
            select_manager.from(Source.sections)
            select_manager.where(subquery.exists.not)
            
            source = Arel::Nodes::JoinSource.new(select_manager,[])

            insert_manager = Arel::InsertManager.new Database.source_engine
            insert_manager.columns << Source.___industries[:name] 
            insert_manager.into(Source.___industries)
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
