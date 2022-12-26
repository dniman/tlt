namespace :corrs do
  namespace :ul do
    namespace :destination do
      namespace :mss_viw_ocval_scorrapp do
        namespace :date_e_org do

          task :insert do |t|
            def link_app_prop_query
              Destination.mss_objcorr_props
              .project(Destination.mss_objcorr_props[:link])
              .where(Destination.mss_objcorr_props[:code].eq('DATE_E_ORG'))
            end

            def query
              link_app_prop = Destination.execute_query(link_app_prop_query.to_sql).entries.first["link"]

              Source.clients
              .project([
                Source.___ids[:___link].as("link_app_up"),
                Arel.sql("#{ link_app_prop }").as("link_app_prop"),
                Source.clients[:exists_end].as("datetime"),
              ])
              .join(Source.___ids).on(Source.___ids[:id].eq(Source.clients[:id]).and(Source.___ids[:table_id].eq(Source::Clients.table_id)))
              .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
              .join(Source.privates, Arel::Nodes::OuterJoin).on(Source.privates[:clients_id].eq(Source.clients[:id]))
              .where(Source.client_types[:name].eq('Юридическое лицо')
                .and(Source.clients[:exists_end].not_eq(nil))
              )
            end

            begin
              sql = ""
              insert = []
              condition =<<~SQL
                mss_viw_ocval_scorrapp.link_app_up = values_table.link_app_up
                  and mss_viw_ocval_scorrapp.link_app_prop = values_table.link_app_prop
                  and mss_viw_ocval_scorrapp.datetime = values_table.datetime
              SQL

              Source.execute_query(query.to_sql).each_slice(1000) do |rows|
                rows.each do |row|
                  insert << {
                    link_app_up: row["link_app_up"],
                    link_app_prop: row["link_app_prop"],
                    datetime: row["datetime"].is_a?(Time) ? row["datetime"].strftime("%Y%m%d") : row["datetime"],
                  }
                end

                sql = Destination::MssViwOcvalScorrapp.insert_query(rows: insert, condition: condition)
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
