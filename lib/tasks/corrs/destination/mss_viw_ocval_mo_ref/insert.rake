namespace :corrs do
  namespace :destination do
    namespace :mss_viw_ocval_mo_ref do

      task :insert do |t|
        def link_app_prop_query
          Destination.set_engine!
          query = 
            Destination.mss_objcorr_props
            .project(Destination.mss_objcorr_props[:link])
            .where(Destination.mss_objcorr_props[:code].eq('MO_REF'))
        end

        def query
          Source.set_engine!

          query = 
            Source.ids
            .project([
              Source.ids[:___link],
            ])
            .where(Source.ids[:table_id].eq(Source::Clients.table_id))
        end

        begin
          link_app_prop = Destination.execute_query(link_app_prop_query.to_sql).entries.first["link"]

          sql = ""
          insert = []
          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            rows.each do |row|
              insert << {
                link_app_up: row["___link"],
                link_app_prop: link_app_prop,
                link_mo: Destination.link_mo, 
              }
            end

            condition =<<~SQL
              mss_viw_ocval_mo_ref.link_app_up = values_table.link_app_up
                and mss_viw_ocval_mo_ref.link_app_prop = #{ link_app_prop }
                and mss_viw_ocval_mo_ref.link_mo = #{ Destination.link_mo }
            SQL

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
