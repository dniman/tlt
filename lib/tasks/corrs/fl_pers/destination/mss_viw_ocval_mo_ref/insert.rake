namespace :corrs do
  namespace :fl_pers do
    namespace :destination do
      namespace :mss_viw_ocval_mo_ref do

        task :insert do |t|
          def link_app_prop_query
            Destination.mss_objcorr_props
            .project(Destination.mss_objcorr_props[:link])
            .where(Destination.mss_objcorr_props[:code].eq('MO_REF'))
          end

          def query
            Source.___ids
            .project([
              Source.___ids[:___link],
            ])
            .join(Source.clients).on(Source.clients[:id].eq(Source.___ids[:id]))
            .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
            .where(
              Source.client_types[:name].eq('Физическое лицо')
              .and(Source.___ids[:table_id].eq(Source::Clients.table_id))
            )
          end

          begin
            link_app_prop = Destination.execute_query(link_app_prop_query.to_sql).entries.first["link"]

            sql = ""
            insert = []
            condition =<<~SQL
              mss_viw_ocval_mo_ref.link_app_up = values_table.link_app_up
                and mss_viw_ocval_mo_ref.link_app_prop = #{ link_app_prop }
                and mss_viw_ocval_mo_ref.link_mo = #{ Destination.link_mo }
            SQL

            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
              rows.each do |row|
                insert << {
                  link_app_up: row["___link"],
                  link_app_prop: link_app_prop,
                  link_mo: Destination.link_mo, 
                }
              end

              sql = Destination::MssViwOcvalMoRef.insert_query(rows: insert, condition: condition)
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
