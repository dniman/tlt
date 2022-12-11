namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update___link_type_a do |t|

        def query
          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___ids[:link].as("___link_a"),
            Source.___ids[:link_type].as("___link_type_a"),
          ])
          manager.from(Source.___paycards)
          manager.join(Source.___ids).on(
            Source.___ids[:id].eq(Source.___paycards[:___agreement_id])
            .and(Source.___ids[:table_id].eq(Source::Agreements.table_id))
          )
        end

        begin
          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___paycards set 
                ___paycards.___link_type_a = values_table.___link_type_a
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ___paycards.___link_a = values_table.___link_a
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
