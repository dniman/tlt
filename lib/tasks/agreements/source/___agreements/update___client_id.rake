namespace :agreements do
  namespace :source do
    namespace :___agreements do

      task :update___client_id do |t|

        def query
          Source.movesets
          .project(
            Source.movesets[:___agreement_id],
            Source.movesets[:___client_id],
          )
          .distinct
          .join(Source.___agreements).on(Source.___agreements[:id].eq(Source.movesets[:___agreement_id]))
          .where(Source.___agreements[:___client_id].eq(nil))
        end

        begin
          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update ___agreements set 
                  ___agreements.___ground_owner = values_table.___ground_owner
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
