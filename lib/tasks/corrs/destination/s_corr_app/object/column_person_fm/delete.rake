namespace :corrs do
  namespace :destination do
    namespace :s_corr_app do
      namespace :object do
        namespace :column_person_fm do

          task :delete do |t|
            def query
              Source.ids
              .project(Source.ids[:link])
              .join(Source.clients).on(Source.clients[:id].eq(Source.ids[:id]))
              .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
              .where(Source.ids[:table_id].eq(Source::Clients.table_id)
                .and(Source.client_types[:name].eq('Физическое лицо'))
              )
            end

            begin
              sql = ""
              sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
              sliced_rows.each do |rows|
                condition =<<~SQL
                  s_corr_app.object = #{ Destination::SCorrApp::COLUMN_PERSON_FM }
                SQL

                sql = Destination::SCorrApp.delete_query(links: rows.map(&:values), condition: condition)
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
