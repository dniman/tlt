namespace :paycards do
  namespace :destination do
    namespace :paycard do

      task :insert2 do |t|
        def len
          Arel::Nodes::NamedFunction.new('len', [ Source.___paycards[:number] ]) 
        end

        def query
          ___ids2 = Source.___ids.alias("___ids2")
          ___paycards2 = Source.___paycards.alias("___paycards2")

          Source.___paycards
          .project([
            Source.___paycards[:link_a],
            Source.___ids[:row_id],
            ___ids2[:link].as("link_up"),
            Source.___paycards[:sincedate],
            Source.___paycards[:enddate],
            Source.___paycards[:corr1],
          ])
          .join(Source.___ids).on(Source.___ids[:id].eq(Source.___paycards[:id]).and(Source.___ids[:table_id].eq(Source::Paycards.table_id)))
          .join(___paycards2, Arel::Nodes::OuterJoin).on(
            ___paycards2[:moveperiod_id].eq(Source.___paycards[:parent_moveperiod_id])
            .and(___paycards2[:prev_moveperiod_id].eq(nil))
            .and(___paycards2[:obligationtype_id].eq(Source.___paycards[:obligationtype_id]))
          )
          .join(___ids2, Arel::Nodes::OuterJoin).on(
            ___ids2[:id].eq(___paycards2[:id])
            .and(___ids2[:table_id].eq(Source::Paycards.table_id))
          )
          .where(Source.___paycards[:prev_moveperiod_id].not_eq(nil))
          .order([Source.___paycards[:link_a], Source.___paycards[:sincedate], Source.___paycards[:obligationtype_id], len, Source.___paycards[:number]]) 
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
                link_up: row["link_up"],
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
