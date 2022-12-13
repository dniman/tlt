namespace :payments do
  namespace :destination do
    namespace :rem1 do

      task :insert do |t|
        def link_self_query
          Destination.rem1
          .project(Destination.rem1[:link])
          .where(Destination.rem1[:object].eq(Destination::SObjects.obj_id('REFERENCE_HANDMADE_VIP')))
        end

        def query 
          link_self = Destination.execute_query(link_self_query.to_sql).entries.first["link"]
          
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
          
          paycards = Source.___ids.alias("paycards")
          obligationtype_id = Arel::Nodes::NamedFunction.new('isnull', [ Source.___paycards[:obligationtype_id], Source.payments[:obligationtype_id] ])

          manager = Arel::SelectManager.new Database.source_engine
          manager.project([
            Source.payments[:___object].as("object"),
            Arel.sql("#{link_self}").as("link_self"),
            number.as("number"),
            date.as("date"),
            Source.payments[:apply_date].as("date_exec"),
            Source.payments[:___bcorr].as("corr"),
            Source.payments[:___baccount].as("baccount"),
            Source.___ids["row_id"],
            Source.payments[:___entry].as("entry"),
          ])
          manager.from(Source.payments)
          manager.join(Source.___ids).on(Source.___ids[:id].eq(Source.payments[:id]).and(Source.___ids[:table_id].eq(Source::Payments.table_id)))
          manager.join(Source.___paycards).on(
            Source.___paycards[:moveset_id].eq(Source.payments[:movesets_id])
            .and(obligationtype_id.eq(Source.payments[:obligationtype_id]))
            .and(Source.___paycards[:prev_moveperiod_id].eq(nil))
          )
          manager.join(paycards).on(paycards[:id].eq(Source.___paycards[:id]).and(paycards[:table_id].eq(Source::Paycards.table_id)))
          manager.join(Source.documents, Arel::Nodes::OuterJoin).on(Source.documents[:id].eq(Source.payments[:documents_id]))
          manager.join(Source.ifs_assigned_payments, Arel::Nodes::OuterJoin).on(Source.ifs_assigned_payments[:pay_id].eq(Source.payments[:id]))
          manager.join(Source.ifs_payments, Arel::Nodes::OuterJoin).on(Source.ifs_payments[:id].eq(Source.ifs_assigned_payments[:ifs_payment_id]))
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
                    Arel::Nodes::Quoted.new(row["object"]),
                    Arel::Nodes::Quoted.new(row["link_self"]),
                    Arel::Nodes::Quoted.new(row["number"]),
                    Arel::Nodes::Quoted.new(row["date"].nil? ? nil : row["date"].strftime("%Y%m%d")),
                    Arel::Nodes::Quoted.new(row["date_exec"].nil? ? nil : row["date_exec"].strftime("%Y%m%d")),
                    Arel::Nodes::Quoted.new(row["corr"]),
                    Arel::Nodes::Quoted.new(row["baccount"]),
                    Arel::Nodes::Quoted.new(row["row_id"]),
                    Arel::Nodes::Quoted.new(row["entry"]),
                  ])
              end
            end
            unions << Arel::Nodes::UnionAll.new(selects[0], selects[1])
            selects[2..-1].each do |select| 
              unions << Arel::Nodes::UnionAll.new(unions.last, select)
            end
            insert_manager = Arel::InsertManager.new Database.destination_engine
            insert_manager.columns << Destination.rem1[:object] 
            insert_manager.columns << Destination.rem1[:link_self]
            insert_manager.columns << Destination.rem1[:number]
            insert_manager.columns << Destination.rem1[:date]
            insert_manager.columns << Destination.rem1[:date_exec]
            insert_manager.columns << Destination.rem1[:corr]
            insert_manager.columns << Destination.rem1[:baccount]
            insert_manager.columns << Destination.rem1[:row_id]
            insert_manager.columns << Destination.rem1[:entry]
            insert_manager.into(Destination.rem1)
            insert_manager.select(unions.last)
            sql = insert_manager.to_sql

            #sql = Destination::Rem1.insert_query(rows: insert, condition: "rem1.row_id = values_table.row_id")
            result = Destination.execute_query(sql)
            result.do
            selects.clear
            sql.clear
            unions.clear
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
