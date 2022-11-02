namespace :agreements do
  namespace :source do
    namespace :___agreements do

      task :update___transferbasis_name do |t|

        def query
          Source.movesets
          .project(
            Source.movesets[:___agreement_id],
            Source.transferbasis[:name].as("___transferbasis_name"),
          )
          .distinct
          .join(Source.movetype).on(Source.movetype[:id].eq(Source.movesets[:movetype_id]))
          .join(Source.transferbasis).on(Source.transferbasis[:id].eq(Source.movesets[:transferbasis_id]))
          .where(Source.movetype[:name].eq('Сервитут'))
        end

        begin
          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update ___agreements set 
                  ___agreements.___transferbasis_name = values_table.___transferbasis_name
                from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                where ___agreements.id = values_table.___agreement_id  
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
