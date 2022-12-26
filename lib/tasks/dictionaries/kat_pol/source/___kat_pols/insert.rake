namespace :dictionaries do
  namespace :kat_pol do
    namespace :source do
      namespace :___kat_pols do
        
        task :insert do |t|
          def query
            subquery = Arel::SelectManager.new Database.source_engine
            subquery.project(Arel.star)
            subquery.from(Source.___kat_pols)
            subquery.where(
              Source.___kat_pols[:name].eq(Source.category_client[:name])
            )
             
            select_manager = Arel::SelectManager.new
            select_manager.project([
              Source.category_client[:name],
            ])
            select_manager.distinct
            select_manager.from(Source.category_client)
            select_manager.where(subquery.exists.not)
            
            source = Arel::Nodes::JoinSource.new(select_manager,[])

            insert_manager = Arel::InsertManager.new Database.source_engine
            insert_manager.columns << Source.___kat_pols[:name] 
            insert_manager.into(Source.___kat_pols)
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
