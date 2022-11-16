namespace :paycards do
  namespace :destination do
    namespace :paycard do

      task :insert1 do |t|
        def len
          Arel::Nodes::NamedFunction.new('len', [ Source.___paycards[:number] ]) 
        end

        def query 
          Source.___paycards
          .project([
            Source.___paycards[:link_a],
            Source.___paycards[:number],
            Source.___ids[:row_id],
            Source.___paycards[:sincedate],
            Source.___paycards[:enddate],
            Source.___paycards[:corr1],
          ])
          .join(Source.___ids).on(Source.___ids[:id].eq(Source.___paycards[:id]).and(Source.___ids[:table_id].eq(Source::Paycards.table_id)))
          .where(Source.___paycards[:prev_moveperiod_id].eq(nil))
          .order([Source.___paycards[:link_a], Source.___paycards[:sincedate], len, Source.___paycards[:number]]) 
        end
        
        begin
          sql = ""
          insert = []
          object = Destination::SObjects.obj_id('DOCUMENTS_PC')

          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            rows.each do |row|
              insert << {
                object: object,
                link_a: row["link_a"],
                number: row["number"].strip[0,50],
                row_id: row["row_id"],
                date_b: row["sincedate"].nil? ? nil : row["sincedate"].strftime("%Y%m%d"),
                date_e: row["enddate"].nil? ? nil : row["enddate"].strftime("%Y%m%d"),
                corr1: row["corr1"],
              }
            end
            sql = Destination::Paycard.insert_query(rows: insert, condition: "paycard.row_id = values_table.row_id")
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
