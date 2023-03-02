namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :insert1 do |t|
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
            w.partition(Source.___agreements[:id])
            w.order(cte_table[:sincedate], cte_table[:moveset_id], Source.obligationtype[:id])
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

          number = 
            Arel::Nodes::Case.new()
            .when(cte_table[:prev_moveperiod_id].eq(nil)).then(concat)
            .else(Arel.sql("null"))

          nach_p =
            Arel::Nodes::Case.new()
            .when(Source.paydocs[:periodical].eq('Y')).then(1)
            .when(Source.paydocs[:periodical].eq('Q')).then(2)
            .when(Source.paydocs[:periodical].eq('H')).then(3)
            .when(Source.paydocs[:periodical].eq('G')).then(4)
            .when(Source.paydocs[:periodical].eq('T')).then(1)
            .when(Source.paydocs[:periodical].eq('N')).then(
              Arel::Nodes::Case.new()
              .when(Source.___agreements[:movetype_name].in(['Купля-продажа', 'Приватизация', 'Собственность'])).then(6)
              .else(5)
            )
          
          real_nach_p =
            Arel::Nodes::Case.new()
            .when(Source.paydocs[:periodical].eq('Y')).then(1)
            .when(Source.paydocs[:periodical].eq('Q')).then(2)
            .when(Source.paydocs[:periodical].eq('H')).then(3)
            .when(Source.paydocs[:periodical].eq('G')).then(4)
            .when(Source.paydocs[:periodical].eq('T')).then(1)
            .when(Source.paydocs[:periodical].eq('N')).then(6)

          peny_t =
            Arel::Nodes::Case.new()
            .when(Source.paydocs[:fine_kind].in(['F', 'P']))
              .then(1)
            .when(Source.paydocs[:fine_kind].eq('R'))
              .then(2)

          peny_distribution = 
            Arel::Nodes::Case.new()
            .when(Source.paydocs[:fine_kind].eq('F'))
              .then(
                Arel::Nodes::Case.new()
                .when(Source.paydocs[:calendar_type_id].eq(360)).then(2)
                .when(Source.paydocs[:calendar_type_id].eq(365)).then(3)
              )
            .when(Source.paydocs[:fine_kind].eq('P'))
              .then(1)
            .when(Source.paydocs[:fine_kind].eq('R'))
              .then(1)

          peny_f =
            Arel::Nodes::Case.new()
            .when(Source.paydocs[:fine_kind].eq('F'))
              .then(nil)
            .when(Source.paydocs[:fine_kind].eq('P'))
              .then(Source.paydocs[:finepercent])
            .when(Source.paydocs[:fine_kind].eq('R'))
              .then(Source.paydocs[:calendar_type_id])

          su_d = Source.paydocs[:finedate]
          su_m = Source.paydocs[:finemonths]
          su_t =
            Arel::Nodes::Case.new()
            .when(Source.paydocs[:kind].eq('A'))
            .then(1)
            .when(Source.paydocs[:kind].eq('B'))
            .then(2)
            .when(Source.paydocs[:kind].eq('P'))
            .then(3)
          
          date_f = 
            Arel::Nodes::Case.new()
            .when(Source.___agreements[:movetype_name].in(['Купля-продажа', 'Приватизация', 'Собственность']))
            .then(Arel::Nodes::NamedFunction.new('isnull', [ Source.paydocs[:creditfirstpaydate], cte_table[:sincedate] ]))
            .else(Source.paydocs[:oncepaydate])
          
          date_f_pay = 
            Arel::Nodes::Case.new()
            .when(Source.___agreements[:movetype_name].in(['Купля-продажа', 'Приватизация', 'Собственность']))
            .then(Source.paydocs[:oncepaydate])
            .else(nil)
  
          prc =
            Arel::Nodes::Case.new()
            .when(
              Source.paydocs[:creditpercent].not_eq(nil)
            ).then(
              Arel::Nodes::Multiplication.new(
                Source.paydocs[:creditpercent],
                Arel::Nodes::SqlLiteral.new('3')
              )
            )

          credit_year_days =
            Arel::Nodes::Case.new()
            .when(Source.paydocs[:calendar_type_id].eq(365)).then(2)
            .when(Source.paydocs[:calendar_type_id].eq(366)).then(3)

          summa_f =
            Arel::Nodes::Case.new()
            .when(
              Arel::Nodes::NamedFunction.new('isnull', [ Source.paydocs[:paysize], Arel::Nodes::SqlLiteral.new('0') ]).gt(0)
              .and(Arel::Nodes::NamedFunction.new('isnull', [ Source.paydocs[:creditsize], Arel::Nodes::SqlLiteral.new('0') ]).gteq(0))
              .and(Arel::Nodes::NamedFunction.new('isnull', [ Source.paydocs[:paysize], Arel::Nodes::SqlLiteral.new('0') ]).gteq(
                Arel::Nodes::NamedFunction.new('isnull', [ Source.paydocs[:creditsize], Arel::Nodes::SqlLiteral.new('0') ])
              ))
            ).then(Arel::Nodes::Subtraction.new(Source.paydocs[:paysize], Source.paydocs[:creditsize]))

          kbk_inc_a = Source.cls_kbk.alias("kbk_inc_a")
          kbk_inc_p = Source.cls_kbk.alias("kbk_inc_p")
          kbk_inc_pr = Source.cls_kbk.alias("kbk_inc_pr")

          paysize = 
            Arel::Nodes::Multiplication.new(
              Source.paydocs[:paysize],
              Arel::Nodes::Case.new(Source.paydocs[:periodical])
              .when('Y').then(12)
              .when('Q').then(4)
              .when('H').then(2)
              .when('G').then(1)
              .when('T').then(1)
              .when('N').then(1)
            )

          summa2 = 
            Arel::Nodes::Case.new()
            .when(Source.paydocs[:is_yearly_paysize].eq('Y')).then(Source.paydocs[:paysize])
            .else(paysize)
          
          Source.movesets
            .project(
              Source.movesets[:___agreement_id],
              row_number.as("___order"),
              number.as("number"),
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
              Source.movesets[:client_id].as("client_id1"),
              Source.___agreements[:___client_id].as("client_id2"),
              summa2.as("summa2"),
              kbk_inc_a[:name].as("cinc_a"),
              kbk_inc_p[:name].as("cinc_p"),
              kbk_inc_pr[:name].as("cinc_pr"),
              nach_p.as("nach_p"),
              real_nch_p.as("real_nach_p"),
              peny_t.as("peny_t"),
              peny_distribution.as("peny_distribution"),
              peny_f.as("peny_f"),
              su_d.as("su_d"),
              su_m.as("su_m"),
              su_t.as("su_t"),
              su_d.as("de_d"),
              su_m.as("de_m"),
              su_t.as("de_t"),
              date_f.as("date_f"),
              Source.paydocs[:creditcountmonth].as("amount_period"),
              Source.paydocs[:creditsize].as("credit_rev_sum"),
              date_f_pay.as("date_f_pay"),
              prc.as("prc"),
              summa_f.as("summa_f"),
              credit_year_days.as("credit_year_days"),
              Source.movesets[:is_multi_subject],
              Source.movesets[:in_contract],
              Source.movesets[:in_progress],
            )
            .with(moveperiods_cte)
            .join(cte_table, Arel::Nodes::OuterJoin).on(cte_table[:moveset_id].eq(Source.movesets[:id]))
            .join(Source.___agreements, Arel::Nodes::OuterJoin).on(Source.___agreements[:id].eq(Source.movesets[:___agreement_id]))
            .join(Source.obligations, Arel::Nodes::OuterJoin).on(Source.obligations[:moveset_id].eq(Source.movesets[:id]))
            .join(Source.obligationtype, Arel::Nodes::OuterJoin).on(Source.obligationtype[:id].eq(Source.obligations[:obligationtype_id]))
            .join(Source.paydocs, Arel::Nodes::OuterJoin).on(
              Source.paydocs[:moveperiod_id].eq(cte_table[:id])
              .and(Source.paydocs[:obligationtype_id].eq(Source.obligationtype[:id]))
            )
            .join(Source.movetype, Arel::Nodes::OuterJoin).on(Source.movetype[:id].eq(Source.movesets[:movetype_id]))
            .join(kbk_inc_a, Arel::Nodes::OuterJoin).on(kbk_inc_a[:id].eq(Source.paydocs[:main_cls_kbk_id]))
            .join(kbk_inc_p, Arel::Nodes::OuterJoin).on(kbk_inc_p[:id].eq(Source.paydocs[:fine_cls_kbk_id]))
            .join(kbk_inc_pr, Arel::Nodes::OuterJoin).on(kbk_inc_pr[:id].eq(Source.paydocs[:percent_cls_kbk_id]))
            .where(
              Source.movesets[:___agreement_id].not_eq(nil)
              .and(cte_table[:prev_moveperiod_id].eq(nil))
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
                    'Концессия',
                    'Пользование',
                    'Бессрочное пользование'
              ]))
            )
            .order(Source.___agreements[:id], cte_table[:sincedate],cte_table[:moveset_id], Source.obligationtype[:id])
        end

        begin
          sql = ""
          insert = []

          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            rows.each do |row|
              insert << {
                ___agreement_id: row["___agreement_id"],
                ___order: row["___order"],
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
                client_id1: row["client_id1"],
                client_id2: row["client_id2"],
                summa2: row["summa2"].nil? ? 0 : row["summa2"],
                cinc_a: row["cinc_a"],
                cinc_p: row["cinc_p"],
                cinc_pr: row["cinc_pr"],
                nach_p: row["nach_p"],
                real_nach_p: row["real_nach_p"],
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
                amount_period: row["amount_period"],
                credit_rev_sum: row["credit_rev_sum"],
                date_f_pay: row["date_f_pay"].nil? ? nil : row["date_f_pay"].strftime("%Y%m%d"),
                prc: row["prc"],
                summa_f: row["summa_f"],
                credit_year_days: row["credit_year_days"],
                is_multi_subject: row["is_multi_subject"],
                in_contract: row["in_contract"],
                in_progress: row["in_progress"],
              }
            end

            condition =<<~SQL
              ___paycards.___agreement_id = values_table.___agreement_id
                and isnull(___paycards.number,'') = isnull(values_table.number,'')
                and isnull(___paycards.sincedate, '19000101') = isnull(values_table.sincedate, '19000101')
                and isnull(___paycards.enddate, '19000101') = isnull(values_table.enddate, '19000101')
                and isnull(___paycards.moveperiod_id, 0) = isnull(values_table.moveperiod_id, 0)
                and isnull(___paycards.moveset_id, 0) = isnull(values_table.moveset_id, 0)
                and isnull(___paycards.obligation_id, 0) = isnull(values_table.obligation_id, 0)
                and isnull(___paycards.paydoc_id, 0) = isnull(values_table.paydoc_id, 0)
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
