namespace :paycards do
  namespace :destination do
    namespace :paycard do

      task :delete1 do |t|
        def query
          subquery =
            Source.___ids
            .project(Source.___ids[:id])
            .join(Source.___paycards).on(
              Source.___paycards[:id].eq(Source.___ids[:id])
              .and(Source.___ids[:table_id].eq(Source::Paycards.table_id))
            )
            .where(Source.___paycards[:prev_moveperiod_id].not_eq(nil))
          
          Source.___ids
          .project(Source.___ids[:link])
          .where(Arel::Nodes::In.new(Source.___ids[:id], subquery))
        end

        begin
          sql = ""
          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            sql = Destination::Paycard.delete_query(links: rows.map(&:values))
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