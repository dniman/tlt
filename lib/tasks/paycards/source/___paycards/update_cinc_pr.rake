namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update_cinc_pr do |t|
        def query
          cinc_p =
            Arel::Nodes::Case.new()
            .when(Source.___paycards[:cinc_pr].eq(nil).and(Source.___paycards[:___name_type_a].eq('Неосновательное обогащение (ГС)')))
              .then('91411607090041000140')
            .when(Source.___paycards[:cinc_pr].eq(nil).and(Source.___paycards[:___name_type_a].eq('Неосновательное обогащение (МС)')))
              .then('91411607090042000140')
            .else(Source.___paycards[:cinc_pr])

          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___paycards[:id],
            cinc_p.as("cinc_pr"),
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
                ___paycards.cinc_pr = values_table.cinc_pr
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
