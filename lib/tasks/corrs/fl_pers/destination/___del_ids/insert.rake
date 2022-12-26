namespace :corrs do
  namespace :fl_pers do
    namespace :destination do
      namespace :___del_ids do

        task :insert do |t|
          def query
            Source.___ids
            .project([
              Source.___ids[:table_id],
              Source.___ids[:link],
              Source.___ids[:row_id],
            ])
            .join(Source.clients).on(Source.clients[:id].eq(Source.___ids[:id]))
            .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
            .where(
              Source.client_types[:name].eq('Физическое лицо')
              .and(Source.___ids[:table_id].eq(Source::Clients.table_id))
            )
          end
          
          begin
            sql = ""
            insert = []
           
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
              rows.each do |row|
                insert << {
                  table_id: row["table_id"],
                  link: row["link"],
                  row_id: row["row_id"],
                }
              end

              sql = Destination::DelIds.insert_query(rows: insert)
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
