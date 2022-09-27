namespace :dictionaries do
  namespace :kbk do
    namespace :source do
      namespace :cls_kbk do

        task :update___link_department do |t|
          def query
            Destination.set_engine!
            query =
              Destination.s_kbk
              .project(
                Destination.s_kbk[:code], 
                Destination.s_kbk[:link]
              )
              .where(Destination.s_kbk[:object].eq(Destination::SKbk::DICTIONARY_DEPARTMENT))
            query
          end

          begin
            sliced_rows = Destination.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update cls_kbk set 
                  cls_kbk.___link_department = values_table.link
                from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                where substring(ltrim(rtrim(cls_kbk.name)), 1, 3) = values_table.code  
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
