namespace :corrs do
  namespace :fl_pers do
    namespace :destination do
      namespace :mss_viw_ocval_simple do
        namespace :corr_acc do

          task :insert do |t|
            def link_app_prop_query
              Destination.mss_objcorr_props
              .project(Destination.mss_objcorr_props[:link])
              .where(Destination.mss_objcorr_props[:code].eq('CORR_ACC'))
            end

            def query
              link_app_prop = Destination.execute_query(link_app_prop_query.to_sql).entries.first["link"]

              Source.clients
              .project([
                Source.___ids[:___link].as("link_app_up"),
                Arel.sql("#{ link_app_prop }").as("link_app_prop"),
                Source.clients[:corraccount].as("varchar"),
              ])
              .join(Source.___ids).on(Source.___ids[:id].eq(Source.clients[:id]).and(Source.___ids[:table_id].eq(Source::Clients.table_id)))
              .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
              .join(Source.privates, Arel::Nodes::OuterJoin).on(Source.privates[:clients_id].eq(Source.clients[:id]))
              .where(Source.client_types[:name].eq('Физическое лицо')
                .and(Source.clients[:corraccount].not_eq(nil))
              )
            end

            begin
              sql = ""
              insert = []
              condition =<<~SQL
                mss_viw_ocval_simple.link_app_up = values_table.link_app_up
                  and mss_viw_ocval_simple.link_app_prop = values_table.link_app_prop
                  and mss_viw_ocval_simple.varchar = values_table.varchar
              SQL

              Source.execute_query(query.to_sql).each_slice(1000) do |rows|
                rows.each do |row|
                  insert << {
                    link_app_up: row["link_app_up"],
                    link_app_prop: row["link_app_prop"],
                    varchar: row["varchar"],
                  }
                end

                sql = Destination::MssViwOcvalSimple.insert_query(rows: insert, condition: condition)
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
