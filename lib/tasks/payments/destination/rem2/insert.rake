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
          selects = [] 
          unions = []

          Source.execute_query(query).each_slice(1000) do |rows|
            rows.each do |row|
              Arel::SelectManager.new.tap do |select|
                selects <<
                  select.project([
                    Arel::Nodes::Quoted.new(row["account"]),
                    Arel::Nodes::Quoted.new(row["oper"]),
                    Arel::Nodes::Quoted.new(row["orders"]),
                    Arel::Nodes::Quoted.new(row["link_up"]),
                    Arel::Nodes::Quoted.new(row["row_id"]),
                  ])
              end
            end
            unions << Arel::Nodes::UnionAll.new(selects[0], selects[1])
            selects[2..-1].each do |select| 
              unions << Arel::Nodes::UnionAll.new(unions.last, select)
            end
            insert_manager = Arel::InsertManager.new Database.destination_engine
            insert_manager.columns << Destination.rem2[:account] 
            insert_manager.columns << Destination.rem2[:oper]
            insert_manager.columns << Destination.rem2[:orders]
            insert_manager.columns << Destination.rem2[:link_up]
            insert_manager.columns << Destination.rem2[:row_id]
            insert_manager.into(Destination.rem2)
            insert_manager.select(unions.last)
            sql = insert_manager.to_sql

            #sql = Destination::Rem2.insert_query(rows: insert, condition: condition)
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
