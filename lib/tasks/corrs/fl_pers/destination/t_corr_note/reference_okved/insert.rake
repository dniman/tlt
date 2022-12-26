namespace :corrs do
  namespace :fl_pers do
    namespace :destination do
      namespace :t_corr_note do
        namespace :reference_okved do

          task :insert do |t|
            def query
                Source.clients
                .project([
                  Source.___ids[:link].as("corr"),
                  Source.___ids[:___okved_link].as("note"),
                  Arel.sql("#{ Destination::TCorrNote::REFERENCE_OKVED }").as("object"),
                ])
                .join(Source.___ids).on(Source.___ids[:id].eq(Source.clients[:id]).and(Source.___ids[:table_id].eq(Source::Clients.table_id)))
                .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
                .join(Source.privates, Arel::Nodes::OuterJoin).on(Source.privates[:clients_id].eq(Source.clients[:id]))
                .where(
                  Source.client_types[:name].eq('Физическое лицо')
                  .and(Source.___ids[:___okved_link].not_eq(nil))
                )
            end

            begin
              sql = ""
              insert = []
              condition =<<~SQL
                t_corr_note.corr = values_table.corr
                  and t_corr_note.note = values_table.note
                  and t_corr_note.object = values_table.object
              SQL
              
              Source.execute_query(query.to_sql).each_slice(1000) do |rows|
                rows.each do |row|
                  insert << {
                    corr: row["corr"],
                    note: row["note"],
                    object: row["object"],
                  }
                end

                sql = Destination::TCorrNote.insert_query(rows: insert, condition: condition)
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
