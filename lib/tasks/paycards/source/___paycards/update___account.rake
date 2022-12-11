namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update___account do |t|
        def link1_query
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.s_account[:link],
          ])
          manager.from(Destination.s_account)
          manager.where(Destination.s_account[:account].eq('04423010700'))
        end
        
        def link2_query
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.s_account[:link],
          ])
          manager.from(Destination.s_account)
          manager.where(Destination.s_account[:account].eq('04423010820'))
        end
        
        def link3_query
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.s_account[:link],
          ])
          manager.from(Destination.s_account)
          manager.where(Destination.s_account[:account].eq('04423D03470'))
        end

        def query
          link1 = Destination.execute_query(link1_query.to_sql).entries.first["link"]
          link2 = Destination.execute_query(link2_query.to_sql).entries.first["link"]
          link3 = Destination.execute_query(link3_query.to_sql).entries.first["link"]

          account =
            Arel::Nodes::Case.new()
            .when(Source.___paycards[:___account].eq(nil).and(Source.___paycards[:___name_type_a].in([
              'Договор купли-продажи помещения',
              'Договор купли-продажи имущества',
              'Договор купли-продажи (выкуп по 159-ФЗ)',
              'Договор купли-продажи здания',
              'Договор аренды недвижимого имущества',
              'Договор аренды рекламных конструкций',
              'Договор аренды помещения',
              'Договор аренды движимого имущества',
              'Договор аренды недвижимого имущества (аренда балансодержателей)',
              'Договор аренды движимого имущества (аренда балансодержателей)',
              'Нераспознанные платежи', 
              'Договор аренды помещения (с единоразовой оплатой)',
              'Договор безвозмездного пользования на имущество', 
              'Договор безвозмездного пользования на имущество (балансодержателей)', 
              'Договор социального найма',
              'Договор специализированного найма',
              'Неосновательное обогащение (Здания)',
              'Концессия',
              'Договор купли-продажи'
            ]))).then(link1)
            .when(Source.___paycards[:___account].eq(nil).and(Source.___paycards[:___name_type_a].in([
              'Соглашение об установлении сервитута (ГС)',
              'Договор аренды земельного участка под строительство (ГС)',
              'Договор аренды земельного участка под строительство (МС)',
              'Договор аренды земельного участка под временными объектами (МС)',
              'Договор аренды земельного участка под временными объектами (ГС)',
              'Договор аренды земельного участка под капитальными объектами (ГС)',
              'Договор аренды земельного участка под капитальными объектами (МС)',
              'Соглашение об установлении сервитута (МС)',
              'Публичный сервитут (ГС)',
              'Публичный сервитут (МС)',
              'Соглашение об установлении сервитута',
              'Публичный сервитут',
              'Договор безвозмездного пользования земельным участком',
              'Договор безвозмездного пользования земельным участком (ГС)',
              'Договор безвозмездного пользования земельным участком (МС)',
              'Договор купли-продажи земельного участка (ГС)',
              'Соглашение о перераспределении (ГС)',
              'Договор купли-продажи земельного участка (МС)',
              'Соглашение о перераспределении (МС)',
              'Договор купли-продажи земельного участка',
              'Соглашение о перераспределении',
              'Неосновательное обогащение (ГС)',
              'Неосновательное обогащение (МС)',
              'Неосновательное обогащение',
              'Договор аренды земельного участка',
              'Договор аренды'
            ]))).then(link2)
            .when(Source.___paycards[:___account].eq(nil).and(Source.___paycards[:___name_type_a].matches("%ОРПР%")))
              .then(link3)

          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___paycards[:id],
            account.as("___account"),
          ])
          manager.from(Source.___paycards)
        end

        begin
          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___paycards set 
                ___paycards.___account = values_table.___account
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ___paycards.id = values_table.id
            SQL

            result = Source.execute_query(sql)
            result.do
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
