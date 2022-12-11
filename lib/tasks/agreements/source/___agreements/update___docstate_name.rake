namespace :agreements do
  namespace :source do
    namespace :___agreements do

      task :update___docstate_name do |t|

        def query
          Source.___agreements
          .project(
            Source.___agreements[:id],
            Arel::Nodes::Case.new()
            .when(
              Source.documents[:docstate_id].eq(nil)
              .and(Source.documents[:executed].eq('Y'))
            ).then('Закрыт')
            .when(
              Source.documents[:docstate_id].eq(nil)
              .and(Source.documents[:executed].eq(nil))
              .and(Source.documents[:is_active].eq('Y'))
            ).then('Действует')
            .when(
              Source.documents[:docstate_id].eq(nil)
              .and(Source.documents[:executed].eq('N'))
              .and(Source.documents[:is_active].eq('Y'))
            ).then('Действует')
            .when(
              Source.___agreements[:document_id].eq(nil)
            ).then('Проект')
            .when(Source.docstate[:name].in([
              'Прекращен, но участок не м.б. истребован',
              'расторгнут',
              'Закрытый проект',
              'АРХИВ ПК "Земля"',
              'Прекращен, но земельный участок не возвращен',
              'Архивный, прекращен',
              'прекращен',
            ])).then('Закрыт')
            .when(Source.docstate[:name].eq('действующий')).then('Действует')
            .when(Source.docstate[:name].eq('проект')).then('Проект')
            .as('___docstate_name'),
          )
          .distinct
          .join(Source.documents, Arel::Nodes::OuterJoin).on(Source.documents[:id].eq(Source.___agreements[:document_id]))
          .join(Source.docstate, Arel::Nodes::OuterJoin).on(Source.docstate[:id].eq(Source.documents[:docstate_id]))
          #.where(Source.documents[:docstate_id].not_eq(nil))
        end

        begin
          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update ___agreements set 
                  ___agreements.___docstate_name = values_table.___docstate_name
                from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                where ___agreements.id = values_table.id  
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
