namespace :charges do
  namespace :destination do
    namespace :rem3 do

      task :delete do |t|
        def query
          Source.___ids
          .project(Source.___ids[:row_id])
          where(Source.___ids[:table_id].eq(Source::Charges.table_id))
        end

        begin
          sql = ""
          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            sql = Destination::Rem3.delete_query(rows)
            result = Destination.execute_query(sql)
            result.do
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
