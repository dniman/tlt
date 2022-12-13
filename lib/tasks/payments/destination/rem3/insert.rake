namespace :payments do
  namespace :destination do
    namespace :rem3 do

      task :insert do |t|
        def default_income
          sql=<<~SQL
            select link from s_kbk where code = 'нар/счетб/д0000000'
          SQL
          Destination.execute_query(sql).entries.first["link"]
        end

        def query 
          income = Arel::Nodes::Case.new
            .when(Source.payments[:___income].eq(nil)).then(default_income)
            .else(Source.payments[:___income])

          manager = Arel::SelectManager.new Database.source_engine
          manager.project([
            Arel.sql("1").as("first_rec"),
            Arel.sql("3").as("dt_ct"),
            income,
            Source.payments[:sum].as("summa"),
            Arel.sql("#{ Destination.link_oktmo }").as("ate"),
            Source.payments[:___bcorr].as("imns"),
            Arel.sql("0").as("status"),
            Source.payments[:___rem2].as("link_up"),
            Source.payments[:___row_id].as("row_id"),
          ])
          manager.from(Source.payments)
          manager.where(Source.payments[:___rem2].not_eq(nil))
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
                    Arel::Nodes::Quoted.new(row["first_rec"]),
                    Arel::Nodes::Quoted.new(row["dt_ct"]),
                    Arel::Nodes::Quoted.new(row["income"]),
                    Arel::Nodes::Quoted.new(row["summa"]),
                    Arel::Nodes::Quoted.new(row["ate"]),
                    Arel::Nodes::Quoted.new(row["imns"]),
                    Arel::Nodes::Quoted.new(row["status"]),
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
            insert_manager.columns << Destination.rem3[:first_rec] 
            insert_manager.columns << Destination.rem3[:dt_ct]
            insert_manager.columns << Destination.rem3[:income]
            insert_manager.columns << Destination.rem3[:summa]
            insert_manager.columns << Destination.rem3[:ate]
            insert_manager.columns << Destination.rem3[:imns]
            insert_manager.columns << Destination.rem3[:status]
            insert_manager.columns << Destination.rem3[:link_up]
            insert_manager.columns << Destination.rem3[:row_id]
            insert_manager.into(Destination.rem3)
            insert_manager.select(unions.last)
            sql = insert_manager.to_sql

            #sql = Destination::Rem3.insert_query(rows: insert, condition: condition)
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
