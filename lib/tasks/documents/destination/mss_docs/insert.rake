namespace :documents do
  namespace :destination do
    namespace :mss_docs do

      task :insert do |t|
        def link_type_query
          Destination.mss_objcorr_types
          .project(Destination.mss_objcorr_types[:link])
          .where(Destination.mss_objcorr_types[:code].eq('doc'))
        end

        def query
          link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

          Source.documents
          .project([
            Source.documents[:docno],
            Source.documents[:docser],
            Source.documents[:docdate].as("date"),
            Source.documents[:explanation],
            Arel.sql("#{link_type}").as("link_type"),
            Arel.sql("#{Destination.link_mo}").as("link_mo"),
            Source.doctypes[:name],
            Source.___ids[:row_id],
            Arel.sql("#{ Destination::MssOacRowstates::CURRENT }").as("link_scd_state")
          ])
          .join(Source.___ids).on(Source.___ids[:id].eq(Source.documents[:id]).and(Source.___ids[:table_id].eq(Source::Documents.table_id)))
          .join(Source.doctypes, Arel::Nodes::OuterJoin).on(Source.doctypes[:id].eq(Source.documents[:doctypes_id]))
        end

        begin
          sql = ""
          insert = []
          condition = "mss_docs.row_id = values_table.row_id"

          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            rows.each do |row|
              insert << {
                num: row["docno"].nil? ? nil : row["docno"].strip[0,50],
                ser: row["docser"].nil? ? nil : row["docser"].strip[0,50],
                date: row["date"].nil? ? nil : row["date"].strftime("%Y%m%d"),
                name: row["name"],
                note: row["explanation"].nil? ? nil : row["explanation"].strip[0,2000],
                link_type: row["link_type"],
                ___type: row["name"],
                link_mo: row["link_mo"],
                link_scd_state: row["link_scd_state"], 
                row_id: row["row_id"],
              }
            end

            sql = Destination::MssDocs.insert_query(rows: insert, condition: condition)
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
