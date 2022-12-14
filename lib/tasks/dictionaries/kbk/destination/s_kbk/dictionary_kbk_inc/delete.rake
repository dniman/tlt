namespace :dictionaries do
  namespace :kbk do
    namespace :destination do
      namespace :s_kbk do
        namespace :dictionary_kbk_inc do

          task :delete do |t|
            def query
              Source.___ids
                .project(Source.___ids[:link])
                .where(Source.___ids[:table_id].eq(Source::ClsKbk.table_id)
                  .and(Source.___ids[:link].not_eq(nil))
                )
            end

            begin
              sql = ""

              Source.execute_query(query.to_sql).each_slice(1000) do |rows|
              
                sql = Destination::SKbk.delete_query(links: rows.map(&:values))
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
end
