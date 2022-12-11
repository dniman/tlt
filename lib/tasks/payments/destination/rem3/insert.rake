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
          insert = []

          Source.execute_query(query).each_slice(1000) do |rows|
          
            rows.each do |row|
              insert << {
                first_rec: row["first_rec"],
                dt_ct: row["dt_ct"],
                income: row["income"],
                summa: row["summa"],
                ate: row["ate"],
                imns: row["imns"],
                status: row["status"],
                link_up: row["link_up"],
                row_id: row["row_id"],
              }
            end

            condition =<<~SQL
              rem3.row_id = values_table.row_id
            SQL

            sql = Destination::Rem3.insert_query(rows: insert, condition: condition)
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
