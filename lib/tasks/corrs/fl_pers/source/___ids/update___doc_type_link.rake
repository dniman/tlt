namespace :corrs do
  namespace :fl_pers do
    namespace :source do
      namespace :___ids do

        task :update___doc_type_link do |t|
          def query
            Destination.s_corr
            .project(
              Destination.s_corr[:link].as("___doc_type_link"),
              Destination.s_corr[:name].as("___doc_type_name"), 
            )
            .where(Destination.s_corr[:object].eq(Destination::TCorrDict::DICTIONARY_PERSON_PASSPORT))
          end

          begin
            Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update ___ids set 
                  ___ids.___doc_type_link = values_table.___doc_type_link
                from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                where ___ids.___doc_type_name = values_table.___doc_type_name
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