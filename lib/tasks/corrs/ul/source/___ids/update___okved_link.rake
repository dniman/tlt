namespace :corrs do
  namespace :ul do
    namespace :source do
      namespace :___ids do

        task :update___okved_link do |t|
          def query
            Destination.s_note
            .project(
              Destination.s_note[:link].as("___okved_link"),
              Destination.s_note[:code].as("___okved_code"), 
            )
            .where(Destination.s_note[:object].eq(Destination::SNote::RCPT_OKVED))
          end

          begin
            sql = ""
            Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update ___ids set 
                  ___ids.___okved_link = values_table.___okved_link
                from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                where ___ids.___okved_code = values_table.___okved_code
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
end
