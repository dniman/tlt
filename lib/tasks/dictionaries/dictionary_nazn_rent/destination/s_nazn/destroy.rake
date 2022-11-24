namespace :dictionaries do
  namespace :dictionary_nazn_rent do
    namespace :destination do
      namespace :s_nazn do

        task :delete do |t|
          def query
            Source.___ids
            .project(Source.___ids[:link])
            .where(Source.___ids[:table_id].eq(Source::FuncUsing.table_id))
          end

          begin
            sql = ""
            sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              sql = Destination::SNazn.delete_query(links: rows.map(&:values))
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
end
