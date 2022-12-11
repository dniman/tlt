namespace :payments do
  namespace :source do
    namespace :payments do

      task :update___paycard_id do |t|
        def query
          manager = Arel::SelectManager.new Database.source_engine
          manager.project(
            Source.payments[:id],
            Source.___paycards[:id].as("___paycard_id"),
          )
          manager.from(Source.payments)
          manager.join(Source.___paycards).on(
            Source.___paycards[:moveset_id].eq(Source.payments[:movesets_id])
            .and(Source.___paycards[:obligationtype_id].eq(Source.payments[:obligationtype_id]))
            .and(Source.___paycards[:prev_moveperiod_id].eq(nil))
          )
          manager.to_sql
        end

        begin
          sql = ''

          Source.execute_query(query).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update payments set 
                payments.___paycard_id = values_table.___paycard_id
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where payments.id = values_table.id
            SQL

            result = Source.execute_query(sql)
            result.do
            sql.clear
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
