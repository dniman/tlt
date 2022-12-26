namespace :corrs do
  namespace :ul do
    namespace :destination do
      namespace :t_corr_dict do
        namespace :reference_corr_type do

          task :insert do |t|
            def link_type_query(code)
              Destination.s_corr
              .project(Destination.s_corr[:link])
              .where(Destination.s_corr[:inn].eq(code)
                .and(Destination.s_corr[:object].eq(Destination::SCorr::DICTIONARY_CORR_TYPE))
              )
            end

            def query
              ul = Destination.execute_query(link_type_query('UL').to_sql).entries.first["link"]

              Source.clients
              .project([
                Source.___ids[:link],
                Arel.sql(ul.to_s).as("corr_dict"),
                Arel.sql("#{ Destination::TCorrDict::REFERENCE_CORR_TYPE }").as("object"),
              ])
              .join(Source.___ids).on(Source.___ids[:id].eq(Source.clients[:id]).and(Source.___ids[:table_id].eq(Source::Clients.table_id)))
              .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
              .join(Source.organisations, Arel::Nodes::OuterJoin).on(Source.organisations[:clients_id].eq(Source.clients[:id]))
              .where(Source.client_types[:name].eq('Юридическое лицо'))
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
                    corr_dict: row["corr_dict"],
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
