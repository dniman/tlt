namespace :documents do
  namespace :destination do
    namespace :mss_docs do

      task :insert do |t|
        def link_type_query
          Destination.mss_objcorr_types
          .project(Destination.mss_objcorr_types[:link])
          .where(Destination.mss_objcorr_types[:code].eq('doc'))
        end

        def link_scd_state_query
          Destination.mss_oac_rowstates
          .project(Destination.mss_oac_rowstates[:link])
          .where(Destination.mss_oac_rowstates[:code].eq("current"))
        end

        def query
          Source.documents
          .project([
            Source.documents[:docno],
            Source.documents[:docser],
            Source.documents[:docdate],
            Source.documents[:explanation],
            Source.doctypes[:name],
            Source.___ids[:row_id],
          ])
          .join(Source.___ids).on(Source.___ids[:id].eq(Source.documents[:id]).and(Source.___ids[:table_id].eq(Source::Documents.table_id)))
          .join(Source.doctypes, Arel::Nodes::OuterJoin).on(Source.doctypes[:id].eq(Source.documents[:doctypes_id]))
        end

        begin
          sql = ""
          insert = []

          link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]
          link_scd_state = Destination.execute_query(link_scd_state_query.to_sql).entries.first["link"]

          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            rows.each do |row|
              insert << {
                num: row["docno"].nil? ? nil : row["docno"].strip[0,50],
                ser: row["docser"].nil? ? nil : row["docser"].strip[0,50],
                name: row["explanation"].nil? ? nil : row["explanation"].strip[0,2000],
                link_type: link_type,
                ___type: row["name"],
                link_mo: Destination.link_mo,
                link_scd_state: link_scd_state, 
                row_id: row["row_id"],
              }
            end
            sql = Destination::MssDocs.insert_query(rows: insert, condition: "mss_docs.row_id = values_table.row_id")
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
