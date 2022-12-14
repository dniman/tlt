namespace :agreements do
  namespace :source do
    namespace :movesets do

      task :update___agreement_id do |t|
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

          select_one = Arel::SelectManager.new
          select_one.project([
              Source.movesets[:id],
              Source.___agreements[:id].as("___agreement_id")
            ])
          select_one.distinct
          select_one.from(t)
          select_one.join(Source.movesets).on(Source.movesets[:docset_id].eq(t[:docset_id]))
          select_one.join(Source.movetype, Arel::Nodes::OuterJoin).on(Source.movetype[:id].eq(Source.movesets[:movetype_id]))
          select_one.join(Source.___agreements).on(Source.___agreements[:document_id].eq(t[:document_id]).and(Source.___agreements[:movetype_name].eq(movetype_name)))
          select_one.where(Source.movesets[:___agreement_id].eq(nil))

          number = Arel::Nodes::NamedFunction.new('cast', [Source.___agreements[:number].as('int')])

          select_two =
            Source.movesets
            .project([
              Source.movesets[:id],
              Source.___agreements[:id].as("___agreement_id")
            ])
            .distinct
            .join(Source.movetype, Arel::Nodes::OuterJoin).on(Source.movetype[:id].eq(Source.movesets[:movetype_id]))
            .join(Source.___agreements).on(number.eq(Source.movesets[:id]).and(Source.___agreements[:document_id].eq(nil)).and(Source.___agreements[:movetype_name].eq(movetype_name)))
            .where(Source.movesets[:___agreement_id].eq(nil))
            
          union = select_one.union :all, select_two
          union_table = Arel::Table.new :union_table

          manager = Arel::SelectManager.new
          manager.project(Arel.star)
          manager.from(union_table.create_table_alias(union,:union_table))
          
        end

        begin
          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update movesets set 
                movesets.___agreement_id = values_table.___agreement_id
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where movesets.id = values_table.id  
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
