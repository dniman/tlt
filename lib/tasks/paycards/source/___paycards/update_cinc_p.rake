namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update_cinc_p do |t|
        def query
          cinc_p =
            Arel::Nodes::Case.new()
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Договор аренды недвижимого имущества')))
              .then('90311607090040003140')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Договор аренды земельного участка под строительство (ГС)')))
              .then('91411607090040000140')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Договор аренды земельного участка под строительство (МС)')))
              .then('91411607090042000140')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Договор аренды земельного участка под временными объектами (ГС)')))
              .then('91411607090041000140')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Договор аренды земельного участка под капитальными объектами (ГС)')))
              .then('91411607090041000140')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Договор аренды земельного участка под временными объектами (МС)')))
              .then('91411607090042000140')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Договор аренды земельного участка под капитальными объектами (МС)')))
              .then('91411607090042000140')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Соглашение об установлении сервитута (ГС)')))
              .then('91411105312040000120')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Публичный сервитут (ГС)')))
              .then('91411105312040000120')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Соглашение об установлении сервитута (МС)')))
              .then('91411105324040000120')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Публичный сервитут (МС)')))
              .then('91411105324040000120')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Договор купли-продажи земельного участка (ГС)')))
              .then('91411406012040000430')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Соглашение о перераспределении (ГС)')))
              .then('91411406012040000430')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Договор купли-продажи земельного участка (МС)')))
              .then('91411406024040000430')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Соглашение о перераспределении (МС)')))
              .then('91411406024040000430')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Неосновательное обогащение (ГС)')))
              .then('91411607090041000140')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Неосновательное обогащение (МС)')))
              .then('91411607090042000140')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Договор аренды недвижимого имущества (аренда балансодержателей)')))
              .then('нар/счетб/д0000000')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Договор аренды движимого имущества (аренда балансодержателей)')))
              .then('нар/счетб/д0000000')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Договор безвозмездного пользования на имущество')))
              .then('нар/счетб/д0000000')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Договор безвозмездного пользования земельным участком')))
              .then('нар/счетб/д0000000')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Договор безвозмездного пользования на имущество (балансодержателей)')))
              .then('нар/счетб/д0000000')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Договор безвозмездного пользования земельным участком (ГС)')))
              .then('нар/счетб/д0000000')
            .when(Source.___paycards[:cinc_p].eq(nil).and(Source.___paycards[:___name_type_a].eq('Договор безвозмездного пользования земельным участком (МС)')))
              .then('нар/счетб/д0000000')
            .else(
              Arel::Nodes::Case.new()
              .when(Source.___paycards[:cinc_p].eq(nil)).then('нар/счетб/д0000000')
              .else(Source.___paycards[:cinc_p])
            )

          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___paycards[:id],
            cinc_p.as("cinc_p"),
          ])
          manager.from(Source.___paycards)
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update ___paycards set 
              ___paycards.cinc_p = values_table.cinc_p
            from ___paycards
              join (
                #{ query }
              ) values_table(id, cinc_p) on values_table.id = ___paycards.id
          SQL

          Source.execute_query(sql).do
          
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
