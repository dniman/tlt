namespace :charges do
  namespace :destination do
    namespace :___charge_save do

      task :insert do |t|

        def query 
          paycards = Source.___ids.alias("paycards")

          type =
            Arel::Nodes::Case.new()
              .when(Source.charges[:charge_type].in(['OBLIGATION', 'OTHER'])).then(1)
              .when(Source.charges[:charge_type].matches("%FINE%")).then(2)
              .when(Source.charges[:charge_type].eq('PERCENT').and(Source.___paycards[:___name_type_a].matches("%купли-продажи%"))).then(16)
              .when(Source.charges[:charge_type].eq('PERCENT').and(Source.___paycards[:___name_type_a].matches("%аренда%"))).then(4)
          
          note =
            Arel::Nodes::NamedFunction.new('convert', [ 
              Arel.sql('varchar(250)'), 
              Arel::Nodes::Case.new()
                .when(
                  Source.___paycards[:___name_type_a].does_not_match("%купли-продажи%")
                    .and(Source.charges[:comments].not_eq('Сумма по договору'))
                ).then(Source.charges[:comments])
                .else(Arel::Nodes::NamedFunction.new('isnull', [ Source.payments_plan[:comments], Source.charges[:comments] ]))
            ])
         
          ___cinc =
            Arel::Nodes::Case.new()
            .when(Source.charges[:charge_type].in(['OBLIGATION', 'OTHER']).and(Source.charges[:cls_kbk_id].eq(nil))).then(Source.___paycards[:cinc_a])
            .when(Source.charges[:charge_type].matches("%FINE%").and(Source.charges[:cls_kbk_id].eq(nil))).then(Source.___paycards[:cinc_p])
            .else(Source.cls_kbk[:name])

          date_exec = 
            Arel::Nodes::Case.new()
            .when(Source.___paycards[:___name_type_a].does_not_match('Неосновательное обогащение%')
              .or(Source.___paycards[:___name_type_a].matches('Неосновательное обогащение%')
                .and(Source.___paycards[:___name_objtype].eq(nil)
                  .or(Source.___paycards[:___name_objtype].not_eq('Земельные участки'))
                )
              )
              .and(Source.charges[:charge_type].in(['OBLIGATION', 'OTHER', 'PERCENT']))
              .and(Source.charges[:chargedate].gt("19000101"))
              .and(Source.___paycards[:___name_type_a].does_not_match('%купли-продажи%'))
            ).then(Arel.sql("dateadd(day, -1, charges.chargedate)"))
            .else(
              Arel::Nodes::Case.new()
              .when(Source.___paycards[:___name_type_a].matches('%купли-продажи%')).then(
                Arel::Nodes::NamedFunction.new('coalesce', [ Source.payments_plan[:finedate], Source.charges[:finedate], Source.charges[:chargedate] ])
              )
              .else(Source.charges[:chargedate])
            )
          
          rdate = 
            Arel::Nodes::Case.new()
            .when(Source.___paycards[:___name_type_a].does_not_match('Неосновательное обогащение%')
              .or(Source.___paycards[:___name_type_a].matches('Неосновательное обогащение%')
                .and(Source.___paycards[:___name_objtype].eq(nil)
                  .or(Source.___paycards[:___name_objtype].not_eq('Земельные участки'))
                )
              )
              .and(Source.charges[:charge_type].in(['OBLIGATION', 'OTHER', 'PERCENT']))
              .and(Source.charges[:chargedate].gt("19000101"))
              .and(Source.___paycards[:___name_type_a].does_not_match('%купли-продажи%'))
            ).then(Arel.sql("dateadd(day, -1, charges.chargedate)"))
            .else(
              Arel::Nodes::Case.new()
              .when(Source.___paycards[:___name_type_a].matches('%купли-продажи%')).then(
                Arel::Nodes::NamedFunction.new('coalesce', [ Source.payments_plan[:finedate], Source.charges[:finedate], Source.charges[:chargedate] ])
              )
              .else(Source.charges[:chargedate])
            )

          summa =
            Arel::Nodes::Case.new()
              .when(
                Source.___paycards[:___name_type_a].does_not_match("%купли-продажи%")
                  .and(Source.charges[:comments].not_eq('Сумма по договору'))
              ).then(Source.charges[:paysize])
              .else(Arel::Nodes::NamedFunction.new('coalesce', [ Source.payments_plan[:val], Source.charges[:paysize] ]))

          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Arel.sql("-1").as("link"),
            Arel.sql("1").as("upd"),
            paycards[:link].as("pc"), 
            type.as("type"),
            date_exec.as("date_exec"),
            rdate.as("rdate"),
            Source.charges[:calperiod_start].as("date_b"),
            Source.charges[:calperiod_end].as("date_e"),
            summa.as("summa"),
            note.as("note"),
            ___cinc.as("___cinc"),
            Arel.sql("1").as("on_schedule"),
            Source.___paycards[:___account].as("acc"),
            Arel.sql("#{ Destination.link_oktmo }").as("ate"),
            Source.___paycards[:___corr1].as("___corr1"),
            Source.___ids["row_id"],
          ])
          manager.distinct
          manager.from(Source.___charges)
          manager.join(Source.charges).on(Source.charges[:id].eq(Source.___charges[:charges_id]))
          manager.join(Source.___paycards).on(
            Source.___paycards[:moveset_id].eq(Source.charges[:movesets_id])
            .and(Source.___paycards[:prev_moveperiod_id].eq(nil))
            .and(Source.charges[:obligationtype_id].eq(Source.___paycards[:obligationtype_id]))
          )
          manager.join(paycards).on(paycards[:id].eq(Source.___paycards[:id]).and(paycards[:table_id].eq(Source::Paycards.table_id)))
          manager.join(Source.___ids).on(Source.___ids[:id].eq(Source.___charges[:id]).and(Source.___ids[:table_id].eq(Source::Charges___.table_id)))
          manager.join(Source.cls_kbk, Arel::Nodes::OuterJoin).on(Source.cls_kbk[:id].eq(Source.charges[:cls_kbk_id]))
          manager.join(Source.payments_plan, Arel::Nodes::OuterJoin).on(
            Source.payments_plan[:charges_id].eq(Source.charges[:id])
              .and(Source.payments_plan[:id].eq(Source.___charges[:payments_plan_id]))
          )
        end
        
        begin
          sql = ""
          insert = []

          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            rows.each do |row|
              insert << {
                link: row["link"],
                upd: row["upd"],
                pc: row["pc"],
                type: row["type"],
                date_exec: row["date_exec"].nil? ? nil : row["date_exec"].strftime("%Y%m%d"),
                rdate: row["rdate"].nil? ? nil : row["rdate"].strftime("%Y%m%d"),
                date_b: row["date_b"].nil? ? nil : row["date_b"].strftime("%Y%m%d"),
                date_e: row["date_e"].nil? ? nil : row["date_e"].strftime("%Y%m%d"),
                summa: row["summa"],
                note: row["note"],
                ___cinc: row["___cinc"],
                on_schedule: row["on_schedule"],
                acc: row["acc"],
                ate: row["ate"],
                ___corr1: row["___corr1"],
                row_id: row["row_id"],
              }
            end
            
            sql = Destination::ChargeSave.insert_query(rows: insert, condition: "___charge_save.row_id = values_table.row_id")
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
