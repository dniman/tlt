namespace :agreements do
  namespace :source do
    namespace :___agreements do

      task :update___transferbasis_link do |t|

        def query
          Destination.s_note
          .project(
            Destination.s_note[:link].as("___transferbasis_link"),
            Destination.s_note[:value].as("___transferbasis_name"),
          )
          .distinct
          .where(Destination.s_note[:object].eq(Destination::SObjects.obj_id('DICTIONARY_AGREE_MODE')))
        end

        begin
          sliced_rows = Destination.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update ___agreements set 
                  ___agreements.___transferbasis_link = values_table.___transferbasis_link
                from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                where ___agreements.___transferbasis_name = values_table.___transferbasis_name
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
