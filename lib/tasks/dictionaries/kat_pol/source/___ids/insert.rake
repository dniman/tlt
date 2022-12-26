namespace :dictionaries do
  namespace :kat_pol do
    namespace :source do
      namespace :___ids do

        task :insert do |t|
          def query
            subquery = Arel::SelectManager.new Database.source_engine
            subquery.project(Arel.star)
            subquery.from(Source.___ids)
            subquery.where(
              Source.___ids[:id].eq(Source.___kat_pols[:id])
              .and(Source.___ids[:table_id].eq(Source::KatPols.table_id))
            )
             
            select_manager = Arel::SelectManager.new
            select_manager.project([
              Arel.sql("table_id = #{Source::KatPols.table_id}"),
              Source.___kat_pols[:id],
              Arel::Nodes::NamedFunction.new('newid', []).as("row_id")
            ])
            select_manager.from(Source.___kat_pols)
            select_manager.where(subquery.exists.not)
            
            source = Arel::Nodes::JoinSource.new(select_manager,[])

            insert_manager = Arel::InsertManager.new Database.source_engine
            insert_manager.columns << Source.___ids[:table_id] 
            insert_manager.columns << Source.___ids[:id]
            insert_manager.columns << Source.___ids[:row_id]
            insert_manager.into(Source.___ids)
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
end
