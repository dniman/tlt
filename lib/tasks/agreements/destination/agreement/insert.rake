namespace :agreements do
  namespace :destination do
    namespace :agreement do

      task :insert do |t|
        def query
          ___ids2 = Source.___ids.alias("___ids2")
          ___ids3 = Source.___ids.alias("___ids3")

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
            Source.documents[:explanation],
            Source.___agreements[:___transferbasis_link],
            Source.per_dog[:per_in_month],
            Source.___agreements[:___docstate_link],
            Source.registeredusers[:fullname],
            Source.docendprich[:name].as("termination_contract"),
            Arel::Nodes::Case.new()
              .when(Source.___agreements[:___client_id].eq(Destination.link_mo)).then(Source.___agreements[:___client_id])
              .else(___ids3[:link]).as("client_link"),
          ])
          .join(Source.___ids).on(Source.___ids[:id].eq(Source.___agreements[:id]).and(Source.___ids[:table_id].eq(Source::Agreements.table_id)))
          .join(Source.documents, Arel::Nodes::OuterJoin).on(Source.documents[:id].eq(Source.___agreements[:document_id]))
          .join(___ids2, Arel::Nodes::OuterJoin).on(___ids2[:id].eq(Source.___agreements[:document_id]).and(___ids2[:table_id].eq(Source::Documents.table_id)))
          .join(Source.per_dog, Arel::Nodes::OuterJoin).on(Source.per_dog[:id].eq(Source.documents[:per_dog_id]))
          .join(Source.registeredusers, Arel::Nodes::OuterJoin).on(Source.registeredusers[:username].eq(Source.documents[:moved_user]))
          .join(Source.docendprich, Arel::Nodes::OuterJoin).on(Source.docendprich[:id].eq(Source.documents[:docendprich_id]))
          .join(___ids3, Arel::Nodes::OuterJoin).on(___ids3[:id].eq(Source.___agreements[:___client_id]).and(___ids3[:table_id].eq(Source::Clients.table_id)))
        end

        begin
          sql = ""
          insert = []
          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
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
                note_osn: row["explanation"],
                mode: row["___transferbasis_link"],
                term: row["per_in_month"],
                status: row["___docstate_link"],
                isp: row["fullname"],
                termination_contract: row["termination_contract"],
                corr_link: row["client_link"],
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
