namespace :dictionaries do
  namespace :dictionary_bank do
    namespace :source do
      namespace :___ids do

        task :update_link do |t|
          def query
            Destination.s_bank
            .project(
              Destination.s_bank[:link], 
              Destination.s_bank[:bic], 
            )
          end

          begin
            Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update ___ids set 
                  ___ids.link = values_table.link
                from ___ids
                  join ___client_banks on ___client_banks.id = ___ids.id
                  join (#{values_list.to_sql}) values_table(#{columns.join(', ')}) on values_table.bic = ___client_banks.bic
                where ___ids.table_id = #{ Source::ClientBanks.table_id }
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
