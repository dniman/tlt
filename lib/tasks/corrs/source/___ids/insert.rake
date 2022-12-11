namespace :corrs do
  namespace :source do
    namespace :___ids do

      task :insert do |t|
        def query
          select_one = 
            Source.clients
            .project([
              Arel.sql("table_id = #{Source::Clients.table_id}"),
              Source.clients[:id],
              Arel.sql("row_id = newid()")
            ])
            .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
            .where(Source.client_types[:name].eq('Физическое лицо'))

          select_two =
            Source.clients
            .project([
              Arel.sql("table_id = #{Source::Clients.table_id}"),
              Source.clients[:id],
              Arel.sql("row_id = newid()")
            ])
            .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
            .where(Source.client_types[:name].eq('Юридическое лицо'))

          union = select_one.union :all, select_two
          union_table = Arel::Table.new :union_table

          subquery = Arel::SelectManager.new Database.source_engine
          subquery.project(Arel.star)
          subquery.from(Source.___ids)
          subquery.where(
            Source.___ids[:id].eq(union_table[:id])
            .and(Source.___ids[:table_id].eq(union_table[:table_id]))
          )
           
          select_manager = Arel::SelectManager.new
          select_manager.project([
            union_table[:table_id],
            union_table[:id],
            union_table[:row_id],
          ])
          select_manager.from(union_table.create_table_alias(union,:union_table))
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
