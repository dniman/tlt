namespace :corrs do
  namespace :ul do
    namespace :destination do
      namespace :s_corr_app do
        namespace :object do
          namespace :mss_ref_corr_r_num do

            task :insert do |t|

              def query
                Source.clients
                .project([
                  Source.___ids[:link].as("link_up"),
                  Source.objects[:regno].as("value"),
                  Arel.sql("#{ Destination::SCorrApp::MSS_REF_CORR_R_NUM }").as("object"),
                ])
                .join(Source.___ids).on(Source.___ids[:id].eq(Source.clients[:id]).and(Source.___ids[:table_id].eq(Source::Clients.table_id)))
                .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
                .join(Source.organisations, Arel::Nodes::OuterJoin).on(Source.organisations[:clients_id].eq(Source.clients[:id]))
                .join(Source.objects, Arel::Nodes::OuterJoin).on(Source.objects[:id].eq(Source.organisations[:objects_id]))
                .where(
                  Source.client_types[:name].eq('Юридическое лицо')
                  .and(Source.objects[:regno].not_eq(nil))
                )
              end

              begin
                sql = ""
                insert = []
                condition =<<~SQL
                  s_corr_app.link_up = values_table.link_up
                    and s_corr_app.object = values_table.object
                    and s_corr_app.value = values_table.value
                SQL

                Source.execute_query(query.to_sql).each_slice(1000) do |rows|
                  rows.each do |row|
                    insert << {
                      link_up: row['link'],
                      value: row['value'],
                      object: row['object'],
                    }
                  end
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
end
