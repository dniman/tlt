namespace :objects do
  namespace :exright_intellprop do
    namespace :source do
      namespace :___ids do

        task :insert do |t|
          def link_type_query
            Destination.mss_objects_types 
            .project(Destination.mss_objects_types[:link])
            .where(Destination.mss_objects_types[:code].eq("EXRIGHT_INTELLPROP"))
          end

          def query
            link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

            subquery = Arel::SelectManager.new Database.source_engine
            subquery.project(Arel.star)
            subquery.from(Source.___ids)
            subquery.where(
              Source.___ids[:id].eq(Source.objects[:id])
              .and(Source.___ids[:table_id].eq(Source::Objects.table_id))
            )
             
            select_manager = Arel::SelectManager.new
            select_manager.project([
              Arel.sql("#{Source::Objects.table_id}").as("table_id"),
              Source.objects[:id],
              Arel.sql("#{link_type}").as("link_type"),
              Arel::Nodes::NamedFunction.new('newid', []).as("row_id")
            ])
            select_manager.from(Source.objects)
            select_manager.join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
            select_manager.where(
              Source.objtypes[:name].eq('Интеллектуальная собственность')
              .and(subquery.exists.not)
            )
            
            source = Arel::Nodes::JoinSource.new(select_manager,[])

            insert_manager = Arel::InsertManager.new Database.source_engine
            insert_manager.columns << Source.___ids[:table_id] 
            insert_manager.columns << Source.___ids[:id]
            insert_manager.columns << Source.___ids[:link_type]
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
