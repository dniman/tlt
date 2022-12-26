namespace :corrs do
  namespace :fl_pers do
    namespace :source do
      namespace :___ids do

        task :update___bank_link do |t|
          def query
            client_ids = Arel::Table.new("___ids").alias("client_ids")

            Source.clients
            .project([
              Source.___ids[:id],
              client_ids[:link].as("___bank_link"),
            ])
            .join(Source.___ids).on(Source.___ids[:id].eq(Source.clients[:id]).and(Source.___ids[:table_id].eq(Source::Clients.table_id)))
            .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
            .join(Source.privates, Arel::Nodes::OuterJoin).on(Source.privates[:clients_id].eq(Source.clients[:id]))
            .join(Source.___client_banks, Arel::Nodes::OuterJoin).on(Source.___client_banks[:bic].eq(Source.clients[:bik]))
            .join(client_ids).on(client_ids[:id].eq(Source.___client_banks[:id]).and(client_ids[:table_id].eq(Source::ClientBanks.table_id)))
            .where(Source.client_types[:name].eq('Физическое лицо'))
          end

          begin
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update ___ids set 
                  ___ids.___bank_link = values_table.___bank_link
                from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                where ___ids.id = values_table.id
              SQL
              result = Source.execute_query(sql)
              result.do
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
