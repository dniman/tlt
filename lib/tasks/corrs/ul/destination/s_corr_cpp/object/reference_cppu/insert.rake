namespace :corrs do
  namespace :ul do
    namespace :destination do
      namespace :s_corr_cpp do
        namespace :object do
          namespace :reference_cppu do

            task :insert do |t|
              def query
                Source.clients
                .project([
                  Source.___ids[:link].as("corr"),
                  Source.clients[:kpp].as("cppu"),
                  Arel.sql("#{ Destination::SCorrCpp::REFERENCE_CPPU }").as("object"),
                ])
                .join(Source.___ids).on(Source.___ids[:id].eq(Source.clients[:id]).and(Source.___ids[:table_id].eq(Source::Clients.table_id)))
                .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
                .join(Source.organisations, Arel::Nodes::OuterJoin).on(Source.organisations[:clients_id].eq(Source.clients[:id]))
                .where(
                  Source.client_types[:name].eq('Юридическое лицо')
                  .and(Source.clients[:kpp].not_eq(nil))
                )
              end

              begin
                sql = ""
                insert = []
                Source.execute_query(query.to_sql).each_slice(1000) do |rows|
                  rows.each do |row|
                    insert << {
                      corr: row["corr"],
                      cppu: row["cppu"],
                      object: row["object"],
                    }
                  end
  
                  condition=<<~CONDITION
                    s_corr_cpp.corr = values_table.corr
                      and s_corr_cpp.cppu = values_table.cppu
                      and s_corr_cpp.object = values_table.object
                  CONDITION

                  sql = Destination::SCorrCpp.insert_query(rows: insert, condition: condition)
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
end
