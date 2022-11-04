namespace :agreements do
  namespace :source do
    namespace :___ids do

      task :insert do |t|
        def link_type_query(code)
          Destination.mss_objects_types 
          .project(Destination.mss_objects_types[:link])
          .where(Destination.mss_objects_types[:code].eq(code))
        end
        
        def link_agreement_type_query(name)
          Destination.v_mss_agreements_types 
          .project(Destination.v_mss_agreements_types[:link])
          .where(Destination.v_mss_agreements_types[:name].eq(name))
        end

        def query
          movetype_name = Source.___agreements[:movetype_name]
          name = Arel::Nodes::NamedFunction.new("ltrim", [ Arel::Nodes::NamedFunction.new("rtrim", [ Source.___agreements[:name] ]) ])
          ___ground_owner = Source.___agreements[:___ground_owner]
          #___ground_owner = Arel::Nodes::NamedFunction.new("isnull", [ Source.___agreements[:___ground_owner], Arel.sql("''") ])
          ___ground_owner_count = Source.___agreements[:___ground_owner_count]
          ___transferbasis_name = Source.___agreements[:___transferbasis_name]
          
          type_name1 = 'Договор аренды земельного участка под временными объектами (ГС)'
          type_name2 = 'Договор аренды земельного участка под временными объектами (МС)'
          type_name3 = 'Договор аренды земельного участка под капитальными объектами (ГС)'
          type_name4 = 'Договор аренды земельного участка под капитальными объектами (МС)'
          type_name5 = 'Договор аренды земельного участка под строительство (ГС)'
          type_name6 = 'Договор аренды земельного участка под строительство (МС)'
          type_name7 = 'Договор аренды земельного участка'
          type_name8 = 'Договор аренды земельного участка ОРПР (ГС)'
          type_name9 = 'Договор аренды земельного участка ОРПР (МС)'
          type_name10 = 'Договор аренды земельного участка ОРПР'
          type_name11 = 'Договор купли-продажи земельного участка (ГС)'
          type_name12 = 'Договор купли-продажи земельного участка (МС)'
          type_name13 = 'Договор купли-продажи земельного участка'
          type_name14 = 'Неосновательное обогащение (ГС)'
          type_name15 = 'Неосновательное обогащение (МС)'
          type_name16 = 'Неосновательное обогащение'
          type_name17 = 'Соглашение об установлении сервитута (ГС)'
          type_name18 = 'Соглашение об установлении сервитута (МС)'
          type_name19 = 'Соглашение об установлении сервитута'
          type_name20 = 'Публичный сервитут (ГС)'
          type_name21 = 'Публичный сервитут (МС)'
          type_name22 = 'Публичный сервитут'
          type_name23 = 'Договор безвозмездного пользования земельным участком (ГС)'
          type_name24 = 'Договор безвозмездного пользования земельным участком (МС)'
          type_name25 = 'Договор безвозмездного пользования земельным участком'
          type_name26 = 'Договор аренды недвижимого имущества'
          type_name27 = 'Договор аренды движимого имущества'
          type_name28 = 'Договор аренды'
          type_name29 = 'Договор аренды недвижимого имущества (аренда балансодержателей)'
          type_name30 = 'Договор купли-продажи имущества'
          type_name31 = 'Неосновательное обогащение (Здания)'
          type_name32 = 'Концессия'
          type_name33 = 'Договор безвозмездного пользования на имущество'
          type_name34 = 'Договор безвозмездного пользования на имущество (балансодержателей)'
          type_name35 = 'Договор аренды помещения'
          type_name36 = 'Договор купли-продажи помещения'
          type_name37 = 'Договор купли-продажи'
          type_name38 = 'Договор аренды'

          link1 = Destination.execute_query(link_agreement_type_query(type_name1).to_sql).entries.first["link"]
          link2 = Destination.execute_query(link_agreement_type_query(type_name2).to_sql).entries.first["link"]
          link3 = Destination.execute_query(link_agreement_type_query(type_name3).to_sql).entries.first["link"]
          link4 = Destination.execute_query(link_agreement_type_query(type_name4).to_sql).entries.first["link"]
          link5 = Destination.execute_query(link_agreement_type_query(type_name5).to_sql).entries.first["link"]
          link6 = Destination.execute_query(link_agreement_type_query(type_name6).to_sql).entries.first["link"]
          link7 = Destination.execute_query(link_agreement_type_query(type_name7).to_sql).entries.first["link"]
          link8 = Destination.execute_query(link_agreement_type_query(type_name8).to_sql).entries.first["link"]
          link9 = Destination.execute_query(link_agreement_type_query(type_name9).to_sql).entries.first["link"]
          link10 = Destination.execute_query(link_agreement_type_query(type_name10).to_sql).entries.first["link"]
          link11 = Destination.execute_query(link_agreement_type_query(type_name11).to_sql).entries.first["link"]
          link12 = Destination.execute_query(link_agreement_type_query(type_name12).to_sql).entries.first["link"]
          link13 = Destination.execute_query(link_agreement_type_query(type_name13).to_sql).entries.first["link"]
          link14 = Destination.execute_query(link_agreement_type_query(type_name14).to_sql).entries.first["link"]
          link15 = Destination.execute_query(link_agreement_type_query(type_name15).to_sql).entries.first["link"]
          link16 = Destination.execute_query(link_agreement_type_query(type_name16).to_sql).entries.first["link"]
          link17 = Destination.execute_query(link_agreement_type_query(type_name17).to_sql).entries.first["link"]
          link18 = Destination.execute_query(link_agreement_type_query(type_name18).to_sql).entries.first["link"]
          link19 = Destination.execute_query(link_agreement_type_query(type_name19).to_sql).entries.first["link"]
          link20 = Destination.execute_query(link_agreement_type_query(type_name20).to_sql).entries.first["link"]
          link21 = Destination.execute_query(link_agreement_type_query(type_name21).to_sql).entries.first["link"]
          link22 = Destination.execute_query(link_agreement_type_query(type_name22).to_sql).entries.first["link"]
          link23 = Destination.execute_query(link_agreement_type_query(type_name23).to_sql).entries.first["link"]
          link24 = Destination.execute_query(link_agreement_type_query(type_name24).to_sql).entries.first["link"]
          link25 = Destination.execute_query(link_agreement_type_query(type_name25).to_sql).entries.first["link"]
          link26 = Destination.execute_query(link_agreement_type_query(type_name26).to_sql).entries.first["link"]
          link27 = Destination.execute_query(link_agreement_type_query(type_name27).to_sql).entries.first["link"]
          link28 = Destination.execute_query(link_agreement_type_query(type_name28).to_sql).entries.first["link"]
          link29 = Destination.execute_query(link_agreement_type_query(type_name29).to_sql).entries.first["link"]
          link30 = Destination.execute_query(link_agreement_type_query(type_name30).to_sql).entries.first["link"]
          link31 = Destination.execute_query(link_agreement_type_query(type_name31).to_sql).entries.first["link"]
          link32 = Destination.execute_query(link_agreement_type_query(type_name32).to_sql).entries.first["link"]
          link33 = Destination.execute_query(link_agreement_type_query(type_name33).to_sql).entries.first["link"]
          link34 = Destination.execute_query(link_agreement_type_query(type_name34).to_sql).entries.first["link"]
          link35 = Destination.execute_query(link_agreement_type_query(type_name35).to_sql).entries.first["link"]
          link36 = Destination.execute_query(link_agreement_type_query(type_name36).to_sql).entries.first["link"]
          link37 = Destination.execute_query(link_agreement_type_query(type_name37).to_sql).entries.first["link"]
          link38 = Destination.execute_query(link_agreement_type_query(type_name38).to_sql).entries.first["link"]

          # Земельные участки
          land = Destination.execute_query(link_type_query('LAND').to_sql).entries.first["link"]

          select1 = Arel::SelectManager.new
          select1.project([
            Arel.sql("table_id = #{Source::Agreements.table_id}"),
            Source.___agreements[:id],
            Arel.sql("row_id = newid()"),
            Arel::Nodes::Case.new()
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('под временными объектами договор аренды земельного участка'))
                .and(___ground_owner.eq('ГС').or(___ground_owner.eq('РФ')))
                .and(___ground_owner_count.eq(1))
            ).then(link1)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('под временными объектами договор аренды земельного участка'))
                .and(___ground_owner.eq('МС'))
                .and(___ground_owner_count.eq(1))
            ).then(link2)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('под временными объектами договор аренды земельного участка'))
                .and(___ground_owner.not_eq('ГС').or(___ground_owner.not_eq('РФ').or(___ground_owner.not_eq('МС').or(___ground_owner.eq(nil)))))
                .and(___ground_owner_count.eq(1))
            ).then(link7)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('под временными объектами договор аренды земельного участка'))
                .and(___ground_owner_count.gt(1))
            ).then(link7)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('под капитальными объектами договор аренды земельного участка'))
                .and(___ground_owner.eq('ГС').or(___ground_owner.eq('РФ')))
                .and(___ground_owner_count.eq(1))
            ).then(link3)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('под капитальными объектами договор аренды земельного участка'))
                .and(___ground_owner.eq('МС'))
                .and(___ground_owner_count.eq(1))
            ).then(link4)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('под капитальными объектами договор аренды земельного участка'))
                .and(___ground_owner.not_eq('ГС').or(___ground_owner.not_eq('РФ').or(___ground_owner.not_eq('МС').or(___ground_owner.eq(nil)))))
                .and(___ground_owner_count.eq(1))
            ).then(link7)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('под капитальными объектами договор аренды земельного участка'))
                .and(___ground_owner_count.gt(1))
            ).then(link7)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('под строительство договор аренды земельного участка'))
                .and(___ground_owner.eq('ГС').or(___ground_owner.eq('РФ')))
                .and(___ground_owner_count.eq(1))
            ).then(link5)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('под строительство договор аренды земельного участка'))
                .and(___ground_owner.eq('МС'))
                .and(___ground_owner_count.eq(1))
            ).then(link6)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('под строительство договор аренды земельного участка'))
                .and(___ground_owner.not_eq('ГС').or(___ground_owner.not_eq('РФ').or(___ground_owner.not_eq('МС').or(___ground_owner.eq(nil)))))
                .and(___ground_owner_count.eq(1))
            ).then(link7)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('под строительство договор аренды земельного участка'))
                .and(___ground_owner_count.gt(1))
            ).then(link7)
            .when(
              movetype_name.eq('Аренда')
                .and(
                  name.not_eq('под временными объектами договор аренды земельного участка')
                  .or(name.not_eq('под временными объектами договор аренды земельного участка'))
                  .or(name.not_eq('под строительство договор аренды земельного участка'))
                )
            ).then(link7)
            .when(
              movetype_name.eq('Аренда ОРПР')
                .and(___ground_owner.eq('ГС').or(___ground_owner.eq('РФ')))
                .and(___ground_owner_count.eq(1))
            ).then(link8)
            .when(
              movetype_name.eq('Аренда ОРПР')
                .and(___ground_owner.eq('МС'))
                .and(___ground_owner_count.eq(1))
            ).then(link9)
            .when(
              movetype_name.eq('Аренда ОРПР')
                .and(___ground_owner.not_eq('ГС').or(___ground_owner.not_eq('РФ').or(___ground_owner.not_eq('МС').or(___ground_owner.eq(nil)))))
                .and(___ground_owner_count.eq(1))
            ).then(link10)
            .when(
              movetype_name.eq('Аренда ОРПР')
                .and(___ground_owner_count.gt(1))
            ).then(link10)
            .when(
              movetype_name.eq('Купля-продажа')
                .and(___ground_owner.eq('ГС').or(___ground_owner.eq('РФ')))
                .and(___ground_owner_count.eq(1))
            ).then(link11)
            .when(
              movetype_name.eq('Купля-продажа')
                .and(___ground_owner.eq('МС'))
                .and(___ground_owner_count.eq(1))
            ).then(link12)
            .when(
              movetype_name.eq('Купля-продажа')
                .and(___ground_owner.not_eq('ГС').or(___ground_owner.not_eq('РФ').or(___ground_owner.not_eq('МС').or(___ground_owner.eq(nil)))))
                .and(___ground_owner_count.eq(1))
            ).then(link13)
            .when(
              movetype_name.eq('Купля-продажа')
                .and(___ground_owner_count.gt(1))
            ).then(link13)
            .when(
              movetype_name.eq('Собственность')
                .and(___ground_owner.eq('ГС').or(___ground_owner.eq('РФ')))
                .and(___ground_owner_count.eq(1))
            ).then(link11)
            .when(
              movetype_name.eq('Собственность')
                .and(___ground_owner.eq('МС'))
                .and(___ground_owner_count.eq(1))
            ).then(link12)
            .when(
              movetype_name.eq('Собственность')
                .and(___ground_owner.not_eq('ГС').or(___ground_owner.not_eq('РФ').or(___ground_owner.not_eq('МС').or(___ground_owner.eq(nil)))))
                .and(___ground_owner_count.eq(1))
            ).then(link13)
            .when(
              movetype_name.eq('Собственность')
                .and(___ground_owner_count.gt(1))
            ).then(link13)
            .when(
              movetype_name.eq('Фактическое пользование')
                .and(___ground_owner.eq('ГС').or(___ground_owner.eq('РФ')))
                .and(___ground_owner_count.eq(1))
            ).then(link14)
            .when(
              movetype_name.eq('Фактическое пользование')
                .and(___ground_owner.eq('МС'))
                .and(___ground_owner_count.eq(1))
            ).then(link15)
            .when(
              movetype_name.eq('Фактическое пользование')
                .and(___ground_owner.not_eq('ГС').or(___ground_owner.not_eq('РФ').or(___ground_owner.not_eq('МС').or(___ground_owner.eq(nil)))))
                .and(___ground_owner_count.eq(1).or(___ground_owner_count.eq(nil)))
            ).then(link16)
            .when(
              movetype_name.eq('Фактическое пользование')
                .and(___ground_owner_count.gt(1))
            ).then(link16)
            .when(
              movetype_name.eq('Сервитут')
                .and(___ground_owner.eq('ГС').or(___ground_owner.eq('РФ')))
                .and(___ground_owner_count.eq(1))
                .and(___transferbasis_name.not_eq('Публичный'))
            ).then(link17)
            .when(
              movetype_name.eq('Сервитут')
                .and(___ground_owner.eq('МС'))
                .and(___ground_owner_count.eq(1))
                .and(___transferbasis_name.not_eq('Публичный'))
            ).then(link18)
            .when(
              movetype_name.eq('Сервитут')
                .and(___ground_owner.not_eq('ГС').or(___ground_owner.not_eq('РФ').or(___ground_owner.not_eq('МС').or(___ground_owner.eq(nil)))))
                .and(___ground_owner_count.eq(1))
                .and(___transferbasis_name.not_eq('Публичный'))
            ).then(link19)
            .when(
              movetype_name.eq('Сервитут')
                .and(___ground_owner_count.gt(1))
                .and(___transferbasis_name.not_eq('Публичный'))
            ).then(link19)
            .when(
              movetype_name.eq('Сервитут')
                .and(___ground_owner.eq('ГС').or(___ground_owner.eq('РФ')))
                .and(___ground_owner_count.eq(1))
                .and(___transferbasis_name.eq('Публичный'))
            ).then(link20)
            .when(
              movetype_name.eq('Сервитут')
                .and(___ground_owner.eq('МС'))
                .and(___ground_owner_count.eq(1))
                .and(___transferbasis_name.eq('Публичный'))
            ).then(link21)
            .when(
              movetype_name.eq('Сервитут')
                .and(___ground_owner.not_eq('ГС').or(___ground_owner.not_eq('РФ').or(___ground_owner.not_eq('МС').or(___ground_owner.eq(nil)))))
                .and(___ground_owner_count.eq(1))
                .and(___transferbasis_name.eq('Публичный'))
            ).then(link22)
            .when(
              movetype_name.eq('Сервитут')
                .and(___ground_owner_count.gt(1))
                .and(___transferbasis_name.eq('Публичный'))
            ).then(link22)
            .when(
              movetype_name.eq('Безвозмездное пользование')
                .and(___ground_owner.eq('ГС').or(___ground_owner.eq('РФ')))
                .and(___ground_owner_count.eq(1))
            ).then(link23)
            .when(
              movetype_name.eq('Безвозмездное пользование')
                .and(___ground_owner.eq('МС'))
                .and(___ground_owner_count.eq(1))
            ).then(link24)
            .when(
              movetype_name.eq('Безвозмездное пользование')
                .and(___ground_owner.not_eq('ГС').or(___ground_owner.not_eq('РФ').or(___ground_owner.not_eq('МС').or(___ground_owner.eq(nil)))))
                .and(___ground_owner_count.eq(1))
            ).then(link25)
            .when(
              movetype_name.eq('Безвозмездное пользование')
                .and(___ground_owner_count.gt(1))
            ).then(link25)
            .as('link_type'),
          ])
          select1.from(Source.___agreements)
          select1.where(Source.___agreements[:___link_type].eq(land))

          # Нежилые здания
          houses_unlife = Destination.execute_query(link_type_query('HOUSES_UNLIFE').to_sql).entries.first["link"]

          select2 = Arel::SelectManager.new
          select2.project([
            Arel.sql("table_id = #{Source::Agreements.table_id}"),
            Source.___agreements[:id],
            Arel.sql("row_id = newid()"),
            Arel::Nodes::Case.new()
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор аренды недвижимого имущества'))
            ).then(link26)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор аренды движимого имущества'))
            ).then(link27)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор аренды'))
            ).then(link28)
            .when(
              movetype_name.eq('Аренда балансодержателей')
            ).then(link29)
            .when(
              movetype_name.eq('Купля-продажа')
            ).then(link30)
            .when(
              movetype_name.eq('Собственность')
            ).then(link30)
            .when(
              movetype_name.eq('Приватизация')
            ).then(link30)
            .when(
              movetype_name.eq('Фактическое пользование')
            ).then(link31)
            .when(
              movetype_name.eq('Концессия')
            ).then(link32)
            .when(
              movetype_name.eq('Безвозмездное пользование')
            ).then(link33)
            .when(
              movetype_name.eq('Безв.польз.балансодержателей')
            ).then(link34)
            .as('link_type'),
          ])
          select2.from(Source.___agreements)
          select2.where(Source.___agreements[:___link_type].eq(houses_unlife))

          # Жилое здание
          houses_life = Destination.execute_query(link_type_query('HOUSES_LIFE').to_sql).entries.first["link"]

          select3 = Arel::SelectManager.new
          select3.project([
            Arel.sql("table_id = #{Source::Agreements.table_id}"),
            Source.___agreements[:id],
            Arel.sql("row_id = newid()"),
            Arel::Nodes::Case.new()
            .when(
              movetype_name.eq('Собственность')
            ).then(link30)
            .as('link_type'),
          ])
          select3.from(Source.___agreements)
          select3.where(Source.___agreements[:___link_type].eq(houses_life))

          # Нежилое помещение
          unlife_room = Destination.execute_query(link_type_query('UNLIFE_ROOM').to_sql).entries.first["link"]

          select4 = Arel::SelectManager.new
          select4.project([
            Arel.sql("table_id = #{Source::Agreements.table_id}"),
            Source.___agreements[:id],
            Arel.sql("row_id = newid()"),
            Arel::Nodes::Case.new()
            .when(
              movetype_name.eq('Аренда')
                .and(name.in([
                  'Договор аренды недвижимого имущества',
                  'Договор аренды недвижимого имущества - фактическое использование',
                ]))
            ).then(link35)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор аренды движимого имущества'))
            ).then(link27)
            .when(
              movetype_name.eq('Аренда')
                .and(name.in([
                  'Договор безвозмездного пользования',
                  'Договор срочного безвозмездного пользования',
                ]))
            ).then(link33)
            .when(
              movetype_name.eq('Аренда')
                .and(name.not_in([
                  'Договор аренды недвижимого имущества',
                  'Договор аренды недвижимого имущества - фактическое использование',
                  'Договор аренды движимого имущества',
                  'Договор безвозмездного пользования',
                  'Договор срочного безвозмездного пользования',
                ]))
            ).then(link35)
            .when(
              movetype_name.eq('Аренда балансодержателей')
            ).then(link29)
            .when(
              movetype_name.eq('Купля-продажа')
            ).then(link36)
            .when(
              movetype_name.eq('Собственность')
            ).then(link36)
            .when(
              movetype_name.eq('Приватизация')
            ).then(link36)
            .when(
              movetype_name.eq('Фактическое пользование')
            ).then(link16)
            .when(
              movetype_name.eq('Безвозмездное пользование')
            ).then(link33)
            .when(
              movetype_name.eq('Безв.польз.балансодержателей')
            ).then(link34)
            .as('link_type'),
          ])
          select4.from(Source.___agreements)
          select4.where(Source.___agreements[:___link_type].eq(unlife_room))
          
          # Жилое помещение
          life_room = Destination.execute_query(link_type_query('LIFE_ROOM').to_sql).entries.first["link"]

          select5 = Arel::SelectManager.new
          select5.project([
            Arel.sql("table_id = #{Source::Agreements.table_id}"),
            Source.___agreements[:id],
            Arel.sql("row_id = newid()"),
            Arel::Nodes::Case.new()
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор аренды недвижимого имущества'))
            ).then(link26)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор безвозмездного пользования'))
            ).then(link33)
            .when(
              movetype_name.eq('Аренда балансодержателей')
            ).then(link29)
            .when(
              movetype_name.eq('Собственность')
            ).then(link36)
            .when(
              movetype_name.eq('Фактическое пользование')
            ).then(link16)
            .when(
              movetype_name.eq('Безвозмездное пользование')
            ).then(link33)
            .when(
              movetype_name.eq('Безв.польз.балансодержателей')
            ).then(link34)
            .as('link_type'),
          ])
          select5.from(Source.___agreements)
          select5.where(Source.___agreements[:___link_type].eq(life_room))

          # Сооружение
          construction = Destination.execute_query(link_type_query('CONSTRUCTION').to_sql).entries.first["link"]

          select6 = Arel::SelectManager.new
          select6.project([
            Arel.sql("table_id = #{Source::Agreements.table_id}"),
            Source.___agreements[:id],
            Arel.sql("row_id = newid()"),
            Arel::Nodes::Case.new()
            .when(
              movetype_name.eq('Аренда')
                .and(name.in(['Договор аренды недвижимого имущества', 'МУ аренда']))
            ).then(link26)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор аренды движимого имущества'))
            ).then(link27)
            .when(
              movetype_name.eq('Аренда')
                .and(name.in(['Договор безвозмездного пользования', 'Договор срочного безвозмездного пользования', 'МУ безвозмездное пользование']))
            ).then(link33)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор купли-продажи'))
            ).then(link37)
            .when(
              movetype_name.eq('Аренда')
                .and(name.not_in([
                  'Договор безвозмездного пользования', 
                  'Договор срочного безвозмездного пользования', 
                  'МУ безвозмездное пользование',
                  'Договор аренды недвижимого имущества', 
                  'МУ аренда',
                  'Договор аренды движимого имущества',
                  'Договор купли-продажи',
                ]))
            ).then(link26)
            .when(
              movetype_name.eq('Аренда балансодержателей')
            ).then(link29)
            .when(
              movetype_name.eq('Собственность')
            ).then(link30)
            .when(
              movetype_name.eq('Фактическое пользование')
            ).then(link16)
            .when(
              movetype_name.eq('Безвозмездное пользование')
            ).then(link33)
            .when(
              movetype_name.eq('Безв.польз.балансодержателей')
            ).then(link34)
            .as('link_type'),
          ])
          select6.from(Source.___agreements)
          select6.where(Source.___agreements[:___link_type].eq(construction))

          # Объект незавершенного строительства
          unfinished = Destination.execute_query(link_type_query('UNFINISHED').to_sql).entries.first["link"]

          select7 = Arel::SelectManager.new
          select7.project([
            Arel.sql("table_id = #{Source::Agreements.table_id}"),
            Source.___agreements[:id],
            Arel.sql("row_id = newid()"),
            Arel::Nodes::Case.new()
            .when(
              movetype_name.eq('Аренда балансодержателей')
            ).then(link29)
            .when(
              movetype_name.eq('Собственность')
            ).then(link30)
            .when(
              movetype_name.eq('Безв.польз.балансодержателей')
            ).then(link34)
            .as('link_type'),
          ])
          select7.from(Source.___agreements)
          select7.where(Source.___agreements[:___link_type].eq(unfinished))

          # Транспортное средство
          transport = Destination.execute_query(link_type_query('TRANSPORT').to_sql).entries.first["link"]

          select8 = Arel::SelectManager.new
          select8.project([
            Arel.sql("table_id = #{Source::Agreements.table_id}"),
            Source.___agreements[:id],
            Arel.sql("row_id = newid()"),
            Arel::Nodes::Case.new()
            .when(
              movetype_name.eq('Собственность')
            ).then(link30)
            .when(
              movetype_name.eq('Безвозмездное пользование')
            ).then(link33)
            .as('link_type'),
          ])
          select8.from(Source.___agreements)
          select8.where(Source.___agreements[:___link_type].eq(transport))

          # Иное движимое имущество
          movable_other = Destination.execute_query(link_type_query('MOVABLE_OTHER').to_sql).entries.first["link"]

          select9 = Arel::SelectManager.new
          select9.project([
            Arel.sql("table_id = #{Source::Agreements.table_id}"),
            Source.___agreements[:id],
            Arel.sql("row_id = newid()"),
            Arel::Nodes::Case.new()
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор аренды недвижимого имущества'))
            ).then(link26)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор аренды движимого имущества'))
            ).then(link27)
            .when(
              movetype_name.eq('Аренда балансодержателей')
            ).then(link29)
            .when(
              movetype_name.eq('Собственность')
            ).then(link30)
            .when(
              movetype_name.eq('Фактическое пользование')
            ).then(link31)
            .when(
              movetype_name.eq('Безвозмездное пользование')
            ).then(link33)
            .as('link_type'),
          ])
          select9.from(Source.___agreements)
          select9.where(Source.___agreements[:___link_type].eq(movable_other))

          # Доля (вклад) в уставном (складочном) капитале
          partnership = Destination.execute_query(link_type_query('PARTNERSHIP').to_sql).entries.first["link"]

          select10 = Arel::SelectManager.new
          select10.project([
            Arel.sql("table_id = #{Source::Agreements.table_id}"),
            Source.___agreements[:id],
            Arel.sql("row_id = newid()"),
            Arel::Nodes::Case.new()
            .when(
              movetype_name.eq('Собственность')
            ).then(link37)
            .as('link_type'),
          ])
          select10.from(Source.___agreements)
          select10.where(Source.___agreements[:___link_type].eq(partnership))

          # Акции
          share = Destination.execute_query(link_type_query('SHARE').to_sql).entries.first["link"]

          select11 = Arel::SelectManager.new
          select11.project([
            Arel.sql("table_id = #{Source::Agreements.table_id}"),
            Source.___agreements[:id],
            Arel.sql("row_id = newid()"),
            Arel::Nodes::Case.new()
            .when(
              movetype_name.eq('Собственность')
            ).then(link37)
            .as('link_type'),
          ])
          select11.from(Source.___agreements)
          select11.where(Source.___agreements[:___link_type].eq(share))

          # Объекты интеллектуальной собственности
          exright_intellprop = Destination.execute_query(link_type_query('EXRIGHT_INTELLPROP').to_sql).entries.first["link"]

          select12 = Arel::SelectManager.new
          select12.project([
            Arel.sql("table_id = #{Source::Agreements.table_id}"),
            Source.___agreements[:id],
            Arel.sql("row_id = newid()"),
            Arel::Nodes::Case.new()
            .when(
              movetype_name.eq('Собственность')
            ).then(link37)
            .as('link_type'),
          ])
          select12.from(Source.___agreements)
          select12.where(Source.___agreements[:___link_type].eq(exright_intellprop))
          
          # nil 
          select13 = Arel::SelectManager.new
          select13.project([
            Arel.sql("table_id = #{Source::Agreements.table_id}"),
            Source.___agreements[:id],
            Arel.sql("row_id = newid()"),
            Arel::Nodes::Case.new()
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор аренды движимого имущества'))
            ).then(link27)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор аренды земельного участка'))
            ).then(link7)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор аренды недвижимого имущества'))
            ).then(link26)
            .when(
              movetype_name.eq('Аренда')
                .and(name.in([
                  'Договор безвозмездного пользования',
                  'Договор срочного безвозмездного пользования',
                ]))
            ).then(link33)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('договор купли-продажи (2,5%)'))
            ).then(link37)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор купли-продажи земельного участка'))
            ).then(link25)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('под капитальными объектами договор аренды земельного участка'))
            ).then(link7)
            .when(
              movetype_name.eq('Аренда')
                .and(name.not_in([
                  'под капитальными объектами договор аренды земельного участка',
                  'Договор купли-продажи земельного участка',
                  'договор купли-продажи (2,5%)',
                  'Договор безвозмездного пользования',
                  'Договор срочного безвозмездного пользования',
                  'Договор аренды недвижимого имущества',
                  'Договор аренды движимого имущества',
                  'Договор аренды земельного участка',
                ]))
            ).then(link38)
            .when(
              movetype_name.eq('Аренда ОРПР')
            ).then(link10)
            .when(
              movetype_name.eq('Аренда балансодержателей')
                .and(name.eq('Договор аренды недвижимого имущества'))
            ).then(link26)
            .when(
              movetype_name.eq('Аренда балансодержателей')
                .and(name.in([
                  'Договор безвозмездного пользования',
                  'МУ безвозмездное пользование',
                ]))
            ).then(link33)
            .when(
              movetype_name.eq('Аренда балансодержателей')
                .and(name.not_in([
                  'Договор безвозмездного пользования',
                  'МУ безвозмездное пользование',
                  'Договор аренды недвижимого имущества',
                ]))
            ).then(link29)
            .when(
              movetype_name.eq('Купля-продажа')
                .and(name.eq('Договор купли-продажи арендуемого имущества'))
            ).then(link37)
            .when(
              movetype_name.eq('Собственность')
                .and(name.in([
                  'Договор купли-продажи недвижимого имущества',
                  'договор купли-продажи недвижимого имущества на аукционе',
                  'Договор купли-продажи недвижимого имущества посредством публичного предложения',
                ]))
            ).then(link30)
            .when(
              movetype_name.eq('Собственность')
                .and(name.eq('Договор купли-продажи земельного участка'))
            ).then(link13)
            .when(
              movetype_name.eq('Собственность')
                .and(name.not_in([
                  'Договор купли-продажи недвижимого имущества',
                  'договор купли-продажи недвижимого имущества на аукционе',
                  'Договор купли-продажи недвижимого имущества посредством публичного предложения',
                  'Договор купли-продажи земельного участка',
                ]))
            ).then(link37)
            .when(
              movetype_name.eq('Приватизация')
            ).then(link37)
            .when(
              movetype_name.eq('Фактическое пользование')
                .and(name.eq('Договор аренды недвижимого имущества - фактическое использование'))
            ).then(link26)
            .when(
              movetype_name.eq('Фактическое пользование')
                .and(name.not_eq('Договор аренды недвижимого имущества - фактическое использование'))
            ).then(link16)
            .when(
              movetype_name.eq('Безвозмездное пользование')
            ).then(link33)
            .when(
              movetype_name.eq('Безв.польз.балансодержателей')
            ).then(link34)
            .as('link_type'),
          ])
          select13.from(Source.___agreements)
          select13.where(Source.___agreements[:___link_type].eq(nil))

          # Инженерная сеть
          engineering_network = Destination.execute_query(link_type_query('ENGINEERING_NETWORK').to_sql).entries.first["link"]

          select14 = Arel::SelectManager.new
          select14.project([
            Arel.sql("table_id = #{Source::Agreements.table_id}"),
            Source.___agreements[:id],
            Arel.sql("row_id = newid()"),
            Arel::Nodes::Case.new()
            .when(
              movetype_name.eq('Аренда')
                .and(name.in(['Договор аренды недвижимого имущества', 'МУ аренда']))
            ).then(link26)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор аренды движимого имущества'))
            ).then(link27)
            .when(
              movetype_name.eq('Аренда')
                .and(name.in(['Договор безвозмездного пользования', 'Договор срочного безвозмездного пользования', 'МУ безвозмездное пользование']))
            ).then(link33)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор купли-продажи'))
            ).then(link37)
            .when(
              movetype_name.eq('Аренда')
                .and(name.not_in([
                  'Договор безвозмездного пользования', 
                  'Договор срочного безвозмездного пользования', 
                  'МУ безвозмездное пользование',
                  'Договор аренды недвижимого имущества', 
                  'МУ аренда',
                  'Договор аренды движимого имущества',
                  'Договор купли-продажи',
                ]))
            ).then(link26)
            .when(
              movetype_name.eq('Аренда балансодержателей')
            ).then(link29)
            .when(
              movetype_name.eq('Собственность')
            ).then(link30)
            .when(
              movetype_name.eq('Фактическое пользование')
            ).then(link16)
            .when(
              movetype_name.eq('Безвозмездное пользование')
            ).then(link33)
            .when(
              movetype_name.eq('Безв.польз.балансодержателей')
            ).then(link34)
            .as('link_type'),
          ])
          select14.from(Source.___agreements)
          select14.where(Source.___agreements[:___link_type].eq(engineering_network))

          # Автомобильная дорога
          automobile_road = Destination.execute_query(link_type_query('AUTOMOBILE_ROAD').to_sql).entries.first["link"]

          select15 = Arel::SelectManager.new
          select15.project([
            Arel.sql("table_id = #{Source::Agreements.table_id}"),
            Source.___agreements[:id],
            Arel.sql("row_id = newid()"),
            Arel::Nodes::Case.new()
            .when(
              movetype_name.eq('Аренда')
                .and(name.in(['Договор аренды недвижимого имущества', 'МУ аренда']))
            ).then(link26)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор аренды движимого имущества'))
            ).then(link27)
            .when(
              movetype_name.eq('Аренда')
                .and(name.in(['Договор безвозмездного пользования', 'Договор срочного безвозмездного пользования', 'МУ безвозмездное пользование']))
            ).then(link33)
            .when(
              movetype_name.eq('Аренда')
                .and(name.eq('Договор купли-продажи'))
            ).then(link37)
            .when(
              movetype_name.eq('Аренда')
                .and(name.not_in([
                  'Договор безвозмездного пользования', 
                  'Договор срочного безвозмездного пользования', 
                  'МУ безвозмездное пользование',
                  'Договор аренды недвижимого имущества', 
                  'МУ аренда',
                  'Договор аренды движимого имущества',
                  'Договор купли-продажи',
                ]))
            ).then(link26)
            .when(
              movetype_name.eq('Аренда балансодержателей')
            ).then(link29)
            .when(
              movetype_name.eq('Собственность')
            ).then(link30)
            .when(
              movetype_name.eq('Фактическое пользование')
            ).then(link16)
            .when(
              movetype_name.eq('Безвозмездное пользование')
            ).then(link33)
            .when(
              movetype_name.eq('Безв.польз.балансодержателей')
            ).then(link34)
            .as('link_type'),
          ])
          select15.from(Source.___agreements)
          select15.where(Source.___agreements[:___link_type].eq(automobile_road))

          union = 
            Arel::Nodes::Union.new(
              Arel::Nodes::Union.new(
                Arel::Nodes::Union.new(
                  Arel::Nodes::Union.new(
                    Arel::Nodes::Union.new(
                      Arel::Nodes::Union.new(
                        Arel::Nodes::Union.new(
                          Arel::Nodes::Union.new(
                            Arel::Nodes::Union.new(
                              Arel::Nodes::Union.new(
                                Arel::Nodes::Union.new(
                                  Arel::Nodes::Union.new(
                                    Arel::Nodes::Union.new(
                                      Arel::Nodes::Union.new(select1, select2), select3
                                    ), select4
                                  ), select5
                                ), select6
                              ), select7
                            ), select8
                          ), select9
                        ), select10
                      ), select11
                    ),select12
                  ),select13
                ),select14
              ),select15
            )

          union_table = Arel::Table.new :union_table

          manager = Arel::SelectManager.new
          manager.project(Arel.star)
          manager.from(union_table.create_table_alias(union,:union_table))
          manager.where(union_table[:link_type].not_eq(nil))
        end

        begin
          sql = ""
          insert = []
          
          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            rows.each do |row|
              insert << {
                table_id: row["table_id"],
                id: row["id"],
                row_id: row["row_id"],
                link_type: row["link_type"],
              }
            end
            sql = Source::Ids.insert_query(rows: insert, condition: "___ids.id = values_table.id and ___ids.table_id = values_table.table_id")
            result = Source.execute_query(sql)
            result.do
            insert.clear
            sql.clear
          end

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
