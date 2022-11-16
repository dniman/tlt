namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :insert2 do |t|
        def query
          cte_table = Arel::Table.new(:cte_table)
          
          select_one = 
            Source.moveperiods
            .project(
              Source.moveperiods[:id],
              Source.moveperiods[:sincedate],
              Source.moveperiods[:enddate],
              Source.moveperiods[:moveset_id],
              Source.moveperiods[:prev_moveperiod_id],
              Source.moveperiods[:id].as("parent_moveperiod_id"),
            )
            .where(Source.moveperiods[:prev_moveperiod_id].eq(nil))
          
          select_two = 
            Source.moveperiods
            .project([
              Source.moveperiods[:id],
              Source.moveperiods[:sincedate],
              Source.moveperiods[:enddate],
              Source.moveperiods[:moveset_id],
              Source.moveperiods[:prev_moveperiod_id],
              cte_table[:parent_moveperiod_id],
            ])
            .join(cte_table).on(cte_table[:id].eq(Source.moveperiods[:prev_moveperiod_id]))

          union = Arel::Nodes::UnionAll.new(select_one, select_two)
          moveperiods_cte = Arel::Nodes::As.new(cte_table, union)
  
          number = 
            Arel::Nodes::Concat.new(
              Arel::Nodes::NamedFunction.new('isnull', [ Source.___agreements[:number], Arel.sql("'б/н'") ]), 
              Arel.sql("'/'")
            )
          
          window = Arel::Nodes::Window.new.tap do |w|
            w.partition(Source.___ids[:link])
            w.order(cte_table[:sincedate], Source.obligationtype[:name])
          end

          row_number = Arel::Nodes::Over.new \
            Arel::Nodes::NamedFunction.new('row_number', []),
            window
          
          row_number_varchar = 
            Arel::Nodes::NamedFunction.new('convert', [ Arel.sql('varchar'), row_number ])

          obligationtype_name = 
            Arel::Nodes::Case.new()
            .when(Source.obligationtype[:name].eq(nil)).then(Arel.sql("''"))
            .else(
              Arel::Nodes::Concat.new(
                Arel::Nodes::Concat.new(Arel.sql("'('"), Source.obligationtype[:name]), Arel.sql("')'")
              )
            )
          
          concat = 
            Arel::Nodes::NamedFunction.new(
              'convert', 
              [ 
                Arel.sql('varchar(50)'), 
                Arel::Nodes::Concat.new(
                  Arel::Nodes::Concat.new(number, row_number_varchar), obligationtype_name
                )
              ]
            )
          
          clients = Source.___ids.alias("clients")

          Source.movesets
            .project(
              Source.movesets[:___agreement_id],
              Source.___ids[:link].as("link_a"),
              concat.as("number"),
              cte_table[:sincedate],
              cte_table[:enddate],
              cte_table[:id].as("moveperiod_id"),
              cte_table[:prev_moveperiod_id],
              cte_table[:parent_moveperiod_id],
              cte_table[:moveset_id],
              Source.obligations[:id].as("obligation_id"),
              Source.obligations[:obligationtype_id],
              Source.obligationtype[:name].as("obligationtype_name"),
              Source.paydocs[:id].as("paydoc_id"),
              clients[:link].as("corr1"),
            )
            .distinct
            .with(moveperiods_cte)
            .join(cte_table, Arel::Nodes::OuterJoin).on(cte_table[:moveset_id].eq(Source.movesets[:id]))
            .join(Source.___ids, Arel::Nodes::OuterJoin).on(
              Source.___ids[:id].eq(Source.movesets[:___agreement_id])
              .and(Source.___ids[:table_id].eq(Source::Agreements.table_id))
            )
            .join(Source.___agreements, Arel::Nodes::OuterJoin).on(Source.___agreements[:id].eq(Source.movesets[:___agreement_id]))
            .join(Source.obligations, Arel::Nodes::OuterJoin).on(Source.obligations[:moveset_id].eq(Source.movesets[:id]))
            .join(Source.obligationtype, Arel::Nodes::OuterJoin).on(Source.obligationtype[:id].eq(Source.obligations[:obligationtype_id]))
            .join(Source.paydocs, Arel::Nodes::OuterJoin).on(
              Source.paydocs[:moveperiod_id].eq(cte_table[:id])
              .and(Source.paydocs[:obligationtype_id].eq(Source.obligationtype[:id]))
            )
            .join(Source.movetype, Arel::Nodes::OuterJoin).on(Source.movetype[:id].eq(Source.movesets[:movetype_id]))
            .join(clients, Arel::Nodes::OuterJoin).on(clients[:id].eq(Source.movesets[:client_id]).and(clients[:table_id].eq(Source::Clients.table_id)))
            .where(
              Source.movesets[:___agreement_id].not_eq(nil)
              .and(cte_table[:prev_moveperiod_id].not_eq(nil))          
              .and(Source.movetype[:name].in([
                    'Аренда', 
                    'Аренда балансодержателей', 
                    'Аренда ОРПР', 
                    'Купля-продажа', 
                    'Собственность', 
                    'Фактическое пользование', 
                    'Сервитут', 
                    'Безвозмездное пользование', 
                    'Безв.польз.балансодержателей', 
                    'Приватизация', 
                    'Концессия'
              ]))
            )
        end

        begin
          sql = ""
          insert = []
          
          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            rows.each do |row|
              insert << {
                ___agreement_id: row["___agreement_id"],
                link_a: row["link_a"],
                number: row["number"],
                sincedate: row["sincedate"].nil? ? nil : row["sincedate"].strftime("%Y%m%d"),
                enddate: row["enddate"].nil? ? nil : row["enddate"].strftime("%Y%m%d"),
                moveperiod_id: row["moveperiod_id"],
                prev_moveperiod_id: row["prev_moveperiod_id"],
                parent_moveperiod_id: row["parent_moveperiod_id"],
                moveset_id: row["moveset_id"],
                obligation_id: row["obligation_id"],
                obligationtype_id: row["obligationtype_id"],
                obligationtype_name: row["obligationtype_name"],
                paydoc_id: row["paydoc_id"],
                corr1: row["corr1"],
              }
            end

            condition =<<~SQL
              isnull(___paycards.number,0) = isnull(values_table.number,0)
                and ___paycards.sincedate = values_table.sincedate
                and ___paycards.enddate = values_table.enddate
                and ___paycards.moveperiod_id = values_table.moveperiod_id
                and ___paycards.moveset_id = values_table.moveset_id
            SQL

            sql = Source::Paycards.insert_query(rows: insert, condition: condition)
            result = Source.execute_query(sql)
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
