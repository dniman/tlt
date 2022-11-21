namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update___sum_rtype do |t|

        def query
          sum_rtype =
            Arel::Nodes::Case.new()
            .when(Source.___paycards[:___name_type_a].matches("%купли-продажи%")).then(nil)
            .else(Arel.sql("2"))

          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___paycards[:id],
            sum_rtype.as("___sum_rtype"),
          ])
          manager.from(Source.___paycards)
        end

        begin
          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___paycards set 
                ___paycards.___sum_rtype = values_table.___sum_rtype
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ___paycards.id = values_table.id
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
