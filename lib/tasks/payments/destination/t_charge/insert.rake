namespace :payments do
  namespace :destination do
    namespace :t_charge do

      task :insert do |t|
        def query 
          object = Arel::Nodes::Case.new
            .when(Source.payments[:sum].lt(0)).then(Destination::TCharge::REFERENCE_PAY_DEBIT)
            .else(Destination::TCharge::REFERENCE_PAY_CREDIT)
          
          summa_a =
            Arel::Nodes::Case.new()
              .when(Source.payments[:mainpay].eq('Y')).then(Source.payments[:sum])
          
          summa_p =
            Arel::Nodes::Case.new()
              .when(Source.payments[:mainpay].eq('N')).then(Source.payments[:sum])

          manager = Arel::SelectManager.new Database.source_engine
          manager.project([
            object.as("object"),
            Source.___ids[:link].as("pc"),
            Source.payments[:___extrem].as("extrem"),
            Source.payments[:apply_date].as("rdate"),
            Source.payments[:apply_date].as("date_exec"),
            summa_a.as("summa_a"),
            summa_p.as("summa_p"),
            Source.payments[:___row_id].as("row_id"),
          ])
          manager.from(Source.payments)
          manager.join(Source.___ids).on(Source.___ids[:id].eq(Source.payments[:___paycard_id]).and(Source.___ids[:table_id].eq(Source::Paycards.table_id)))
          manager.where(Source.payments[:___paycard_id].not_eq(nil))
          manager.to_sql
        end
        
        begin
          sql = ""
          insert = []
          
          condition =<<~SQL
            t_charge.row_id = values_table.row_id
          SQL

          sliced_rows = Source.execute_query(query).each_slice(1000) do |rows|
            rows.each do |row|
              insert << {
                object: row["object"],
                pc: row["pc"],
                extrem: row["extrem"],
                rdate: row["rdate"].nil? ? nil : row["rdate"].strftime("%Y%m%d"),
                date_exec: row["date_exec"].nil? ? nil : row["date_exec"].strftime("%Y%m%d"),
                summa_a: row["summa_a"],
                summa_p: row["summa_p"],
                row_id: row["row_id"],
              }
            end

            sql = Destination::TCharge.insert_query(rows: insert, condition: condition)
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
