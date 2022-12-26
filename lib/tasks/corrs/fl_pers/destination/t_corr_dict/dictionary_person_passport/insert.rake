namespace :corrs do
  namespace :fl_pers do
    namespace :destination do
      namespace :t_corr_dict do
        namespace :dictionary_person_passport do

          task :insert do |t|
            def query
                Source.clients
                .project([
                  Source.___ids[:___doc_type_link],
                  Source.___ids[:link],
                  Arel.sql("#{ Destination::TCorrDict::DICTIONARY_PERSON_PASSPORT }").as("object"),
                ])
                .join(Source.___ids).on(Source.___ids[:id].eq(Source.clients[:id]).and(Source.___ids[:table_id].eq(Source::Clients.table_id)))
                .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
                .join(Source.privates, Arel::Nodes::OuterJoin).on(Source.privates[:clients_id].eq(Source.clients[:id]))
                .where(
                  Source.client_types[:name].eq('Физическое лицо')
                  .and(Source.___ids[:___doc_type_link].not_eq(nil))
                )
            end

            begin
              sql = ""
              insert = []
              condition =<<~SQL
                t_corr_dict.corr_dict = values_table.corr_dict
                  and t_corr_dict.corr = values_table.corr
                  and t_corr_dict.object = values_table.object
              SQL

              Source.execute_query(query.to_sql).each_slice(1000) do |rows|
                rows.each do |row|
                  insert << {
                    corr_dict: row["___doc_type_link"],
                    corr: row["link"],
                    object: row["object"],
                  }
                end

                sql = Destination::TCorrDict.insert_query(rows: insert, condition: condition)
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
