namespace :documents do
  namespace :destination do
    namespace :mss_docs do

      task :delete do |t|
        def query
          Source.set_engine!
          query = 
            Source.ids
            .project(Source.ids[:link])
            .where(Source.ids[:table_id].eq(Source::Documents.table_id)
              .and(Source.ids[:link].not_eq(nil))
            )
        end

        begin
          Destination.execute_query('disable trigger mss_docs_mrchng on mss_docs')

          sql = ""
          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            sql = Destination::MssDocs.delete_query(links: rows.map(&:values))
            result = Destination.execute_query(sql)
            result.do
            sql.clear
          end
          
          Rake.info "Задача '#{ t }' успешно выполнена."
        rescue StandardError => e
          Rake.error "Ошибка при выполнении задачи '#{ t }' - #{e}."
          Rake.info "Текст запроса \"#{ sql }\""

          exit
        ensure
          Destination.execute_query('enable trigger mss_docs_mrchng on mss_docs')
        end
      end

    end
  end
end
