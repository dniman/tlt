namespace :corrs do
  namespace :destination do
    namespace :s_corr_app do
      namespace :object do
        namespace :column_person_ot do

          task :insert do |t|
            def query
              Source.clients
              .project([
                Source.ids[:link],
                Source.privates[:fullname]
              ])
              .join(Source.ids).on(Source.ids[:id].eq(Source.clients[:id]).and(Source.ids[:table_id].eq(Source::Clients.table_id)))
              .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
              .join(Source.privates, Arel::Nodes::OuterJoin).on(Source.privates[:clients_id].eq(Source.clients[:id]))
              .where(Source.client_types[:name].eq('Физическое лицо')
                .and(Source.privates[:fullname].not_eq(nil))
              )
            end

            begin
              sql = ""
              insert = []
              sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
              sliced_rows.each do |rows|
                rows.each do |row|
                  ot = row["fullname"].strip.split(' ')
                  2.times { ot.shift } if ot.size > 2
                  
                  insert << {
                    link_up: row["link"],
                    value: ot.join(' '),
                    object: Destination::SCorrApp::COLUMN_PERSON_OT,
                  }
                end

                condition =<<~SQL
                  s_corr_app.link_up = values_table.link_up
                    and s_corr_app.value = values_table.value
                    and s_corr_app.object = values_table.object
                SQL

                sql = Destination::SCorrApp.insert_query(rows: insert, condition: condition)
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
  end
end
