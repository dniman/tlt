namespace :agreements do
  namespace :source do
    namespace :___agreements do

      task :insert do |t|
        def docrole_id_query
          Source.docroles
          .project(Source.docroles[:id])
          .where(Source.docroles[:name].eq("Основной документ"))
        end

        def query
          mainrole_id = Source.execute_query(docrole_id_query.to_sql).entries.first["id"]

          t1 = Source.docset_members.alias('t1')

          select1 = Arel::SelectManager.new
          select1.project(t1[:document_id])
          select1.from(t1)
          select1.where(
            t1[:docrole_id].eq(mainrole_id)
            .and(t1[:docset_id].eq(Source.docset_members[:docset_id]))
          )
          select1.order(t1[:document_id].asc)
          select1.take(1)
          
          t2 = Source.docset_members.alias('t2')
          docrole_id = Arel::Nodes::NamedFunction.new('isnull', [ t2[:docrole_id], 0 ])
          
          select2 = Arel::SelectManager.new
          select2.project(t2[:document_id])
          select2.from(t2)
          select2.where(
            docrole_id.not_eq(mainrole_id)
            .and(t2[:docset_id].eq(Source.docset_members[:docset_id]))
          )
          select2.order(t2[:document_id].asc)
          select2.take(1)

          document_id = Arel::Nodes::NamedFunction.new('coalesce', [select1, select2], 'document_id')

          manager = Arel::SelectManager.new
          manager.project([
            Source.docset_members[:docset_id],
            document_id,
          ])
          manager.from(Source.docset_members)
          manager.group(Source.docset_members[:docset_id])
          t = manager.as('t')

          docno = Arel::Nodes::NamedFunction.new("cast", [ Source.movesets[:id].as("varchar(100)") ])
          name = Arel::Nodes::NamedFunction.new("cast", [ Source.movetype[:name].as("varchar(150)") ])
          movetype_name = Arel::Nodes::NamedFunction.new("ltrim", [ Arel::Nodes::NamedFunction.new("rtrim", [ name ]) ])
          movetype_name = 
            Arel::Nodes::Case.new()
            .when(movetype_name.eq('Собственность')).then('Купля-продажа')
            .when(movetype_name.eq('Приватизация')).then('Купля-продажа')
            .else(movetype_name)

          Source.movesets
          .project([
            movetype_name.as('movetype_name'),
            t[:document_id],
            Arel::Nodes::Case.new().when(Source.documents[:id].eq(nil)).then(docno).else(Source.documents[:docno]).as('docno'),
            Arel::Nodes::Case.new().when(Source.documents[:id].eq(nil)).then(name).else(Source.doctypes[:name]).as('name'),
          ])
          .distinct
          .join(Source.movetype, Arel::Nodes::OuterJoin).on(Source.movetype[:id].eq(Source.movesets[:movetype_id]))
          .join(t, Arel::Nodes::OuterJoin).on(t[:docset_id].eq(Source.movesets[:docset_id]))
          .join(Source.documents, Arel::Nodes::OuterJoin).on(Source.documents[:id].eq(t[:document_id]))
          .join(Source.doctypes, Arel::Nodes::OuterJoin).on(Source.doctypes[:id].eq(Source.documents[:doctypes_id]))
          .where(Source.movetype[:name].in([
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
            #'Бессрочное пользование'
          ]))
        end

        begin
          sql = ""
          insert = []
          condition =<<~SQL
            ___agreements.movetype_name = values_table.movetype_name
              and isnull(___agreements.document_id, 0) = isnull(values_table.document_id, 0)
              and ___agreements.number = values_table.number
              and ___agreements.name = values_table.name
          SQL
          
          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            rows.each do |row|
              insert << {
                movetype_name: row["movetype_name"],
                document_id: row["document_id"],
                number: row["docno"],
                name: row["name"],
              }
            end
        
            sql = Source::Agreements.insert_query(rows: insert, condition: condition)
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
