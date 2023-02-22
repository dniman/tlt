namespace :paycards do
  namespace :destination do
    namespace :paycard do

      task :insert2 do |t|
        def len
          Arel::Nodes::NamedFunction.new('len', [ Source.___paycards[:number] ]) 
        end

        def query

          Source.___paycards
          .project([
            Arel.sql("#{ Destination::SObjects.obj_id('DOCUMENTS_PC') }").as("object"),
            Source.___paycards[:___link_a],
            Source.___ids[:row_id],
            Source.___paycards[:___link_up],
            Source.___paycards[:sincedate],
            Source.___paycards[:enddate],
            Source.___paycards[:___corr1],
            Source.___paycards[:___payer_type],
            Source.___paycards[:___corr2],
            Source.___paycards[:summa2],
            Source.___paycards[:___inc_a],
            Source.___paycards[:___inc_p],
            Source.___paycards[:___inc_pr],
            Arel.sql("#{ Destination.link_oktmo }").as("ate"),
            Arel.sql("'NO'").as("first_period"),
            Source.___paycards[:nach_p],
            Source.___paycards[:___sum_rtype],
            Source.___paycards[:peny_t],
            Source.___paycards[:peny_distribution],
            Source.___paycards[:peny_f],
            Source.___paycards[:su_d],
            Source.___paycards[:su_m],
            Source.___paycards[:su_t],
            Source.___paycards[:de_d],
            Source.___paycards[:de_m],
            Source.___paycards[:de_t],
            Source.___paycards[:date_f],
            Source.___paycards[:amount_period],
            Source.___paycards[:credit_rev_sum],
            Source.___paycards[:date_f_pay],
            Source.___paycards[:prc],
            Source.___paycards[:summa_f],
            Source.___paycards[:credit_year_days],
            Source.___paycards[:___account],
            Source.___paycards[:___status],
            Arel.sql("convert(datetime, '20220721')").as("calc_date_b"),
            Arel.sql("convert(datetime, '20220721')").as("calc_date_peny_b"),
          ])
          .join(Source.___ids).on(
            Source.___ids[:id].eq(Source.___paycards[:id])
            .and(Source.___ids[:table_id].eq(Source::Paycards.table_id))
          )
          .where(Source.___paycards[:prev_moveperiod_id].not_eq(nil))
          .order([Source.___paycards[:___link_a], Source.___paycards[:sincedate], Source.___paycards[:obligationtype_id], len, Source.___paycards[:number]]) 
        end

        begin
          sql = ""
          insert = []

          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            rows.each do |row|
              insert << {
                object: row["object"],
                link_a: row["___link_a"],
                link_up: row["___link_up"],
                row_id: row["row_id"],
                date_b: row["sincedate"].nil? ? nil : row["sincedate"].strftime("%Y%m%d"),
                date_e: row["enddate"].nil? ? nil : row["enddate"].strftime("%Y%m%d"),
                corr1: row["___corr1"],
                payer_type: row["___payer_type"],
                corr2: row["___corr2"],
                summa2: row["summa2"],
                autocalcsum: 1,
                inc_a: row["___inc_a"],
                inc_p: row["___inc_p"],
                inc_pr: row["___inc_pr"],
                ate: row["ate"],
                first_period: row["first_period"],
                nach_p: row["nach_p"],
                sum_rtype: row["___sum_rtype"],
                peny_t: row["peny_t"],
                peny_distribution: row["peny_distribution"],
                peny_f: row["peny_f"],
                su_d: row["su_d"],
                su_m: row["su_m"],
                su_t: row["su_t"],
                de_d: row["de_d"],
                de_m: row["de_m"],
                de_t: row["de_t"],
                date_f: row["date_f"].nil? ? nil : row["date_f"].strftime("%Y%m%d"),
                sum_recalc: 1,
                date_e_inclusive: 1,
                amount_period: row["amount_period"],
                credit_rev_sum: row["credit_rev_sum"],
                date_f_pay: row["date_f_pay"].nil? ? nil : row["date_f_pay"].strftime("%Y%m%d"),
                prc: row["prc"],
                summa_f: row["summa_f"],
                credit_year_days: row["credit_year_days"],
                account: row["___account"],
                status: row["___status"],
                calc_date_b: row["calc_date_b"].nil? ? nil : row["calc_date_b"].strftime("%Y%m%d"),
                calc_date_peny_b: row["calc_date_peny_b"].nil? ? nil : row["calc_date_peny_b"].strftime("%Y%m%d"),
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
