namespace :payments do
  namespace :destination do
    namespace :___sys_extrem do

      task :insert do |t|
        def query 
          paycards = Source.___ids.alias("paycards")

          number =
            Arel::Nodes::NamedFunction.new('convert', [ 
              Arel.sql('varchar(10)'), 
              Arel::Nodes::NamedFunction.new('coalesce', [
                Source.ifs_payments[:num_pp],
                Source.documents[:docno],
              ])
          ])

          date = 
            Arel::Nodes::NamedFunction.new('coalesce', [
              Source.ifs_payments[:date_pp], 
              Source.documents[:docdate]
            ])

          summa_a =
            Arel::Nodes::Case.new()
              .when(Source.payments[:mainpay].eq('Y')).then(Source.payments[:sum])
          
          summa_p =
            Arel::Nodes::Case.new()
              .when(Source.payments[:mainpay].eq('N')).then(Source.payments[:sum])

          cppu1 =
            Arel::Nodes::NamedFunction.new('convert', [
              Arel.sql('varchar(9)'), 
              Source.ifs_payments[:kpp_pay], 
            ])
          
          bic1 =
            Arel::Nodes::NamedFunction.new('convert', [
              Arel.sql('varchar(9)'), 
              Source.ifs_payments[:bic_name], 
            ])
          
          bank_n1 =
            Arel::Nodes::NamedFunction.new('convert', [
              Arel.sql('varchar(100)'), 
              Source.ifs_payments[:name_bic_pay], 
            ])

          cppu2 =
            Arel::Nodes::NamedFunction.new('convert', [
              Arel.sql('varchar(9)'), 
              Source.ifs_payments[:kpp_rcp], 
            ])
          
          bic2 =
            Arel::Nodes::NamedFunction.new('convert', [
              Arel.sql('varchar(9)'), 
              Source.ifs_payments[:bic_rcp], 
            ])
          
          bank_n2 =
            Arel::Nodes::NamedFunction.new('convert', [
              Arel.sql('varchar(100)'), 
              Source.ifs_payments[:name_bic_rcp], 
            ])
          
          note1 =
            Arel::Nodes::NamedFunction.new('convert', [
              Arel.sql('varchar(210)'), 
              Source.ifs_payments[:purpose], 
            ])
          
          cbacc_corr =
            Arel::Nodes::NamedFunction.new('convert', [
              Arel.sql('varchar(45)'), 
              Source.ifs_payments[:сname_ubp_rcp]
            ]) 
          
          Source.payments
          .project([
            Arel.sql("1").as("upd"),
            Arel.sql("-1").as("link"),
            paycards[:link].as("pc"),
            number.as("number"),
            Source.ifs_payments[:guid].as("number_el"),
            date.as("date"),
            Source.payments[:apply_date].as("date_exec"),
            Source.payments[:sum].as("summa"),
            summa_a.as("summa_a"),
            summa_p.as("summa_p"),
            cppu1.as("cppu1"),
            bic1.as("bic1"),
            bank_n1.as("bank_n1"),
            Source.ifs_payments[:bs_ks_pay].as("ks1"),
            cppu2.as("cppu2"),
            bic2.as("bic2"),
            bank_n2.as("bank_n2"),
            Source.ifs_payments[:bs_ks_rcp].as("ks2"),
            Source.ifs_payments[:pay_status].as("paystatus"),
            Source.ifs_payments[:okato].as("paycate"),
            Source.ifs_payments[:osnplat].as("payreason"),
            Source.ifs_payments[:nal_per].as("payperiod"),
            Source.ifs_payments[:num_doc].as("payincnumb"),
            Source.ifs_payments[:date_doc].as("payincdate"),
            Source.ifs_payments[:type_pl].as("payinctype"),
            Source.ifs_payments[:kbk].as("paycincome"),
            note1.as("note1"),
            Source.ifs_payments[:inn_pay].as("ccorr1"),
            Source.ifs_payments[:name_bic_pay].as("corr_n1"),
            Source.ifs_payments[:bs_pay].as("caccount1"),
            Source.ifs_payments[:inn_rcp].as("ccorr2"),
            Source.ifs_payments[:сname_ubp_rcp].as("corr_n2"),
            Source.ifs_payments[:order_pay].as("pay_stack"),
            Source.ifs_payments[:uin].as("payuin"),
            Source.___paycards[:___account].as("baccount"),
            Source.ifs_payments[:bs_rcp].as("cbaccount"),
            cbacc_corr.as("cbacc_corr"),
            Arel.sql("1").as("type"),
            Source.___ids["row_id"],
          ])
          .join(Source.___ids).on(Source.___ids[:id].eq(Source.payments[:id]).and(Source.___ids[:table_id].eq(Source::Payments.table_id)))
          .join(Source.___paycards).on(
            Source.___paycards[:moveset_id].eq(Source.payments[:movesets_id])
            .and(Source.___paycards[:obligationtype_id].eq(Source.payments[:obligationtype_id]))
            .and(Source.___paycards[:prev_moveperiod_id].eq(nil))
          )
          .join(paycards).on(paycards[:id].eq(Source.___paycards[:id]).and(paycards[:table_id].eq(Source::Paycards.table_id)))
          .join(Source.documents, Arel::Nodes::OuterJoin).on(Source.documents[:id].eq(Source.payments[:documents_id]))
          .join(Source.ifs_assigned_payments, Arel::Nodes::OuterJoin).on(Source.ifs_assigned_payments[:pay_id].eq(Source.payments[:id]))
          .join(Source.ifs_payments, Arel::Nodes::OuterJoin).on(Source.ifs_payments[:id].eq(Source.ifs_assigned_payments[:ifs_payment_id]))
        end

        begin
          sql = ""
          insert = []

          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            rows.each do |row|
              insert << {
                upd: row["upd"],
                link: row["link"],
                pc: row["pc"],
                number: row["number"],
                number_el: row["number_el"],
                date: row["date"].nil? ? nil : row["date"].strftime("%Y%m%d"),
                date_exec: row["date_exec"].nil? ? nil : row["date_exec"].strftime("%Y%m%d"),
                summa: row["summa"],
                summa_a: row["summa_a"],
                summa_p: row["summa_p"],
                cppu1: row["cppu1"],
                bic1: row["bic1"],
                bank_n1: row["bank_n1"],
                ks1: row["ks1"],
                cppu2: row["cppu2"],
                bic2: row["bic2"],
                bank_n2: row["bank_n2"],
                ks2: row["ks2"],
                paystatus: row["paystatus"],
                paycate: row["paycate"],
                payreason: row["payreason"],
                payperiod: row["payperiod"],
                payincnumb: row["payincnumb"],
                payincdate: row["payincdate"],
                payinctype: row["payinctype"],
                paycincome: row["paycincome"],
                note1: row["note1"],
                ccorr1: row["ccorr1"],
                corr_n1: row["corr_n1"],
                caccount1: row["caccount1"],
                ccorr2: row["ccorr2"],
                corr_n2: row["corr_n2"],
                pay_stack: row["pay_stack"],
                payuin: row["payuin"],
                baccount: row["baccount"],
                cbaccount: row["cbaccount"],
                cbacc_corr: row["cbacc_corr"],
                type: row["type"],
                row_id: row["row_id"],
              }
            end
            sql = Destination::SysExtrem.insert_query(rows: insert, condition: "___sys_extrem.row_pp = values_table.row_pp")
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
