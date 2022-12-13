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
          selects = [] 
          unions = []
          
          #condition =<<~SQL
          #  t_charge.row_id = values_table.row_id
          #SQL

          sliced_rows = Source.execute_query(query).each_slice(1000) do |rows|
            rows.each do |row|
              Arel::SelectManager.new.tap do |select|
                selects <<
                  select.project([
                    Arel::Nodes::Quoted.new(row["object"]),
                    Arel::Nodes::Quoted.new(row["pc"]),
                    Arel::Nodes::Quoted.new(row["extrem"]),
                    Arel::Nodes::Quoted.new(row["rdate"].nil? ? nil : row["rdate"].strftime("%Y%m%d")),
                    Arel::Nodes::Quoted.new(row["date_exec"].nil? ? nil : row["date_exec"].strftime("%Y%m%d")),
                    Arel::Nodes::Quoted.new(row["summa_a"]),
                    Arel::Nodes::Quoted.new(row["summa_p"]),
                    Arel::Nodes::Quoted.new(row["row_id"]),
                  ])
              end
            end
            unions << Arel::Nodes::UnionAll.new(selects[0], selects[1])
            selects[2..-1].each do |select| 
              unions << Arel::Nodes::UnionAll.new(unions.last, select)
            end
            insert_manager = Arel::InsertManager.new Database.destination_engine
            insert_manager.columns << Destination.t_charge[:object] 
            insert_manager.columns << Destination.t_charge[:pc]
            insert_manager.columns << Destination.t_charge[:extrem]
            insert_manager.columns << Destination.t_charge[:rdate]
            insert_manager.columns << Destination.t_charge[:date_exec]
            insert_manager.columns << Destination.t_charge[:summa_a]
            insert_manager.columns << Destination.t_charge[:summa_p]
            insert_manager.columns << Destination.t_charge[:row_id]
            insert_manager.into(Destination.t_charge)
            insert_manager.select(unions.last)
            sql = insert_manager.to_sql

            #sql = Destination::TCharge.insert_query(rows: insert, condition: condition)
            result = Destination.execute_query(sql)
            result.do
            selects.clear
            unions.clear
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
