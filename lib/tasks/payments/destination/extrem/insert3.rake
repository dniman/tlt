namespace :payments do
  namespace :destination do
    namespace :extrem do

      task :insert3 do |t|

        def query 
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
          
          cppu1 =
            Arel::Nodes::NamedFunction.new('convert', [
              Arel.sql('varchar(9)'), 
              Arel::Nodes::NamedFunction.new('isnull', [
                Source.clients[:kpp], 
                Source.ifs_payments[:kpp_pay], 
              ])
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

          ccorr1 =
            Arel::Nodes::NamedFunction.new('convert', [
              Arel.sql('varchar(13)'), 
              Arel::Nodes::NamedFunction.new('isnull', [
                Source.clients[:inn], 
                Source.ifs_payments[:inn_pay], 
              ])
            ])
          
          corr_n1 =
            Arel::Nodes::NamedFunction.new('convert', [
              Arel.sql('varchar(160)'), 
              Source.clients[:name],
            ])

          manager = Arel::SelectManager.new Database.source_engine
          manager.project([
            Source.payments[:___rem1].as("rem1"),
            Source.payments[:___rem3].as("rem3"),
            number.as("number"),
            date.as("date"),
            Source.payments[:apply_date].as("date_exec"),
            Source.payments[:sum].as("summa"),
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
            ccorr1.as("ccorr1"),
            Source.ifs_payments[:bs_pay].as("caccount1"),
            Source.ifs_payments[:inn_rcp].as("ccorr2"),
            Source.ifs_payments[:bs_rcp].as("caccount2"),
            Source.ifs_payments[:order_pay].as("pay_stack"),
            corr_n1.as("corr_n1"),
            Source.ifs_payments[:сname_ubp_rcp].as("corr_n2"),
            Source.ifs_payments[:date_pay].as("pay_date"),
            Source.ifs_payments[:guid].as("number_el"),
            Source.ifs_payments[:uin].as("payuin"),
            Source.payments[:___row_id].as("row_id"),
          ])
          manager.from(Source.payments)
          manager.join(Source.___ids).on(
            Source.___ids[:id].eq(Source.payments[:id])
            .and(Source.___ids[:table_id].eq(Source::Payments.table_id))
          )
          manager.join(Source.documents, Arel::Nodes::OuterJoin).on(Source.documents[:id].eq(Source.payments[:documents_id]))
          manager.join(Source.ifs_assigned_payments, Arel::Nodes::OuterJoin).on(Source.ifs_assigned_payments[:pay_id].eq(Source.payments[:id]))
          manager.join(Source.ifs_payments, Arel::Nodes::OuterJoin).on(Source.ifs_payments[:id].eq(Source.ifs_assigned_payments[:ifs_payment_id]))
          manager.join(Source.clients, Arel::Nodes::OuterJoin).on(Source.clients[:id].eq(Source.payments[:payer_id]))
          manager.to_sql
        end
        
        begin
          sql = ""
          insert = []
          
          condition =<<~SQL
            extrem.row_id = values_table.row_id
          SQL

          Source.execute_query(query).each(:cache_rows => false) do |row|
            insert << { 
              rem1: row["rem1"],
              rem3: row["rem3"],
              number: row["number"],
              date: row["date"].nil? ? nil : row["date"].strftime("%Y%m%d"),
              date_exec: row["date_exec"].nil? ? nil : row["date_exec"].strftime("%Y%m%d"),
              summa: row["summa"],
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
              paycincome: row["payincome"],
              note1: row["note1"],
              ccorr1: row["ccorr1"],
              caccount1: row["caccount1"],
              ccorr2: row["ccorr2"],
              caccount2: row["caccount2"],
              pay_stack: row["pay_stack"],
              corr_n1: row["corr_n1"],
              corr_n2: row["corr_n2"],
              pay_date: row["pay_date"].nil? ? nil : row["pay_date"].strftime("%Y%m%d"),
              number_el: row["number_el"],
              payuin: row["payuin"],
              row_id: row["row_id"],
            } 
            
            next if Database.source.active? && insert.size < 1000
            
            sql = Destination::Extrem.insert_query(rows: insert, condition: condition)
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
