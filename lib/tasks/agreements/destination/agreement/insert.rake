namespace :agreements do
  namespace :destination do
    namespace :agreement do

      task :insert do |t|
        def query
          Source.___agreements
          .project([
            Source.___agreements[:number],
            Source.___agreements[:name],
            Source.___ids[:link_type],
            Source.___ids[:row_id],
            Source.___ids[:___object],
          ])
          .join(Source.___ids).on(Source.___ids[:id].eq(Source.___agreements[:id]).and(Source.___ids[:table_id].eq(Source::Agreements.table_id)))
        end

        begin
          sql = ""
          insert = []
          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            rows.each do |row|
              insert << {
                type: row["link_type"],
                number: row["number"].strip[0,50],
                row_id: row["row_id"],
                object: row["___object"],
                link_mo: Destination.link_mo,
              }
            end
            sql = Destination::Agreement.insert_query(rows: insert, condition: "agreement.row_id = values_table.row_id")
            result = Destination.execute_query(sql)
            result.do
            insert.clear
            sql.clear
          end

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
