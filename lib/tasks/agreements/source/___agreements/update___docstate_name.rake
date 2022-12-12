namespace :agreements do
  namespace :source do
    namespace :___agreements do

      task :update___docstate_name do |t|

        def query
          Source.___agreements
          .project(
            Source.___agreements[:id],
            Source.docstate[:name].as('___docstate_name'),
          )
          .distinct
          .join(Source.documents, Arel::Nodes::OuterJoin).on(Source.documents[:id].eq(Source.___agreements[:document_id]))
          .join(Source.docstate, Arel::Nodes::OuterJoin).on(Source.docstate[:id].eq(Source.documents[:docstate_id]))
        end

        begin
          sql = ""
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
