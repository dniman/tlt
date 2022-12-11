namespace :payments do
  namespace :source do
    namespace :payments do

      task :update___bcorr do |t|
        def query
          manager = Arel::SelectManager.new Database.destination_engine
          manager.project(
            Destination.s_baccount[:link].as("___baccount"),
            Destination.s_baccount[:corr].as("___bcorr"),
          )
          manager.from(Destination.s_baccount)
          manager.to_sql
        end

        begin
          sql = ''

          Destination.execute_query(query).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update payments set 
                payments.___bcorr = values_table.___bcorr
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where payments.___baccount = values_table.___baccount
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
