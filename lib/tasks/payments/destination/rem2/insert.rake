namespace :payments do
  namespace :destination do
    namespace :rem2 do

      task :insert do |t|
        def query 
          manager = Arel::SelectManager.new Database.source_engine
          manager.project([
            Source.payments[:___baccount].as("account"),
            Arel.sql("null").as("oper"),
            Arel.sql("1").as("orders"),
            Source.payments[:___rem1].as("link_up"),
            Source.payments[:___row_id].as("row_id"),
          ])
          manager.from(Source.payments)
          manager.join(Source.___ids).on(
            Source.___ids[:id].eq(Source.payments[:id])
            .and(Source.___ids[:table_id].eq(Source::Payments.table_id))
          )
          manager.to_sql
        end
        
        begin
          sql = ""
          insert = []

          Source.execute_query(query).each_slice(1000) do |rows|
          
            rows.each do |row|
              insert << {
                account: row["account"],
                oper: row["oper"],
                orders: row["orders"],
                link_up: row["link_up"],
                row_id: row["row_id"],
              }
            end

            condition =<<~SQL
              rem2.row_id = values_table.row_id
            SQL

            sql = Destination::Rem2.insert_query(rows: insert, condition: condition)
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
