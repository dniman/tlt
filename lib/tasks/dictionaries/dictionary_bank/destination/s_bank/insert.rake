namespace :dictionaries do
  namespace :dictionary_bank do
    namespace :destination do
      namespace :s_bank do

        task :insert do |t|
          def query
            manager = Arel::SelectManager.new Database.source_engine
            manager.project(
              Source.___client_banks[:name],
              Source.___client_banks[:bic],
              Source.___client_banks[:ks],
              Arel.sql("newid()").as('row_id')
            )
            manager.from(Source.___client_banks)
            manager.to_sql
          end

          begin
            sql = ""
            insert = []
            Source.execute_query(query).each_slice(1000) do |rows|
              rows.each do |row|
                insert << {
                  bic: row['bic'],
                  name: row['name'],
                  ks: row['ks'],
                  row_id: row["row_id"],
                }
              end

              condition =<<~SQL
                s_bank.bic = values_table.bic
              SQL

              sql = Destination::SBank.insert_query(rows: insert, condition: condition)
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
