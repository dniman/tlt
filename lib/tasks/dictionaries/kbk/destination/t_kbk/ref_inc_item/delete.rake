namespace :dictionaries do
  namespace :kbk do
    namespace :destination do
      namespace :t_kbk do
        namespace :ref_inc_item do

          task :delete do |t|
            def query
              Source.ids
                .project(Source.ids[:link])
                .where(Source.ids[:table_id].eq(Source::ClsKbk.table_id)
                  .and(Source.ids[:link].not_eq(nil))
                )
            end

            begin
              sql = ""
              condition =<<~SQL
                t_kbk.object = #{ Destination::TKbk::REF_INC_ITEM }
              SQL

              sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
              sliced_rows.each do |rows|
                sql = Destination::TKbk.delete_query(links: rows.map(&:values), condition: condition)
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
