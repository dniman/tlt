namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update___corr1 do |t|

        def query
          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___paycards[:id],
            Arel::Nodes::Case.new
              .when(Source.___paycards[:client_id1].eq(5100)).then(Destination.link_mo)
              .when(Source.___paycards[:client_id1].eq(nil)).then(nil)
              .else(Source.___ids[:link])
            .as("___corr1"),
          ])
          manager.from(Source.___paycards)
          manager.join(Source.___ids, Arel::Nodes::OuterJoin).on(
            Source.___ids[:id].eq(Source.___paycards[:client_id1])
            .and(Source.___ids[:table_id].eq(Source::Clients.table_id))
          )
        end

        begin
          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___paycards set 
                ___paycards.___corr1 = values_table.___corr1
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
