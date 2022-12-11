namespace :agreements do
  namespace :source do
    namespace :___agreements do

      task :update___ground_owner_count do |t|
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
          select1.order(t1[:id].asc)
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
          select2.order(t2[:id].asc)
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

          select = Arel::SelectManager.new
          select.project([
              t[:document_id],
              Arel::Nodes::Case.new(Source.movesets[:___ground_owner]).when('РФ').then('ГС').else(Source.movesets[:___ground_owner]).as('___ground_owner'),
            ])
          select.distinct
          select.from(Source.movesets)
          select.join(t).on(t[:docset_id].eq(Source.movesets[:docset_id]))
          select.where(Source.movesets[:___ground_owner].not_eq(nil))

          t0 = select.as('t0')
          
          ___ground_owner_count = Arel::Nodes::NamedFunction.new('count', [t0[:document_id]], '___ground_owner_count')

          select0 = Arel::SelectManager.new
          select0.project([
            t0[:document_id],
            ___ground_owner_count,
          ])
          select0.from(t0)
          select0.where(t0[:document_id].not_eq(nil))
          select0.group(t0[:document_id])
        end

        begin
          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___agreements set 
                ___agreements.___ground_owner_count = values_table.___ground_owner_count
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ___agreements.document_id = values_table.document_id  
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
