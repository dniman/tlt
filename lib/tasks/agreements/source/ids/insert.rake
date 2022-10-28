namespace :agreements do
  namespace :source do
    namespace :ids do

      task :insert do |t|
        def query
          Source.___agreements
          .project([
            Arel.sql("table_id = #{Source::Agreements.table_id}"),
            Source.agreements[:id],
            Arel.sql("row_id = newid()")
          ])
          .join(Source.documents, Arel::Nodes::OuterJoin).on(Source.documents[:id].eq(Source.___agreements[:document_id]))
          .where(Source.client_types[:name].eq('Физическое лицо'))
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
