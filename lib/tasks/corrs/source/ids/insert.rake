namespace :corrs do
  namespace :source do
    namespace :ids do

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

          manager = Arel::SelectManager.new
          manager.project(Arel.star)
          manager.from(union_table.create_table_alias(union,:union_table))
        end

        begin
          sql = ""
          insert = []
          
          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            rows.each do |row|
              insert << {
                table_id: row["table_id"],
                id: row["id"],
                row_id: row["row_id"]
              }
            end
            sql = Source::Ids.insert_query(rows: insert, condition: "ids.id = values_table.id and ids.table_id = values_table.table_id")
            result = Source.execute_query(sql)
            result.do
            insert.clear
            sql.clear
          end

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
