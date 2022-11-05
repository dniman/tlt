namespace :agreements do
  namespace :destination do
    namespace :agreement do

      task :insert do |t|
        def query
          ___ids2 = Source.___ids.alias("___ids2")

          Source.___agreements
          .project([
            Source.___agreements[:number],
            Source.___agreements[:name],
            Source.___ids[:link_type],
            Source.___ids[:row_id],
            Source.___ids[:___object],
            ___ids2[:link].as("document_link"),
            Source.documents[:docdate],
            Source.documents[:date_start],
            Source.documents[:date_end],
            Source.documents[:date_exit],
            Source.documents[:gr_num],
            Source.documents[:gr_date],
            Source.documents[:date_archiv],
            Source.documents[:comments],
          ])
          .join(Source.___ids).on(Source.___ids[:id].eq(Source.___agreements[:id]).and(Source.___ids[:table_id].eq(Source::Agreements.table_id)))
          .join(Source.documents, Arel::Nodes::OuterJoin).on(Source.documents[:id].eq(Source.___agreements[:document_id]))
          .join(___ids2, Arel::Nodes::OuterJoin).on(___ids2[:id].eq(Source.___agreements[:document_id]).and(___ids2[:table_id].eq(Source::Documents.table_id)))
        end

        begin
          sql = ""
          insert = []
          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            rows.each do |row|
              insert << {
                type: row["link_type"],
                number: row["number"].strip[0,50],
                row_id: row["row_id"],
                object: row["___object"],
                link_mo: Destination.link_mo,
                date: row["docdate"].nil? ? nil : row["docdate"].strftime("%Y%m%d"),
                date_b: row["date_start"].nil? ? nil : row["date_start"].strftime("%Y%m%d"),
                date_e: row["date_end"].nil? ? nil : row["date_end"].strftime("%Y%m%d"),
                date_canc: row["date_exit"].nil? ? nil : row["date_exit"].strftime("%Y%m%d"),
                date_reg: row["gr_date"].nil? ? nil : row["gr_date"].strftime("%Y%m%d"),
                gos_reg: row["gr_num"],
                date_arch: row["date_arch"].nil? ? nil : row["date_arch"].strftime("%Y%m%d"),
                link_doc_osn: row["document_link"],
                number_osn: row["number"].strip[0,50],
                date_osn: row["docdate"].nil? ? nil : row["docdate"].strftime("%Y%m%d"),
                note_osn: row["comments"],
              }
            end
            sql = Destination::Agreement.insert_query(rows: insert, condition: "agreement.row_id = values_table.row_id")
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
