namespace :dictionaries do
  namespace :kbk do
    namespace :source do
      namespace :cls_kbk do

        task :update___link_item do |t|
          def query
            Destination.s_kbk
            .project(
              Destination.s_kbk[:code], 
              Destination.s_kbk[:link]
            )
            .where(Destination.s_kbk[:object].eq(Destination::SKbk::DICTIONARY_ITEM))
          end

          begin
            Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update cls_kbk set 
                  cls_kbk.___link_item = values_table.link
                from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                where substring(ltrim(rtrim(cls_kbk.name)), 18, 3) = values_table.code  
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
