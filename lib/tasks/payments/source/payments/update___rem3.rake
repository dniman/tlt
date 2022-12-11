namespace :payments do
  namespace :source do
    namespace :payments do

      task :update___rem3 do |t|
        def query
          manager = Arel::SelectManager.new Database.destination_engine
          manager.project(
            Destination.rem3[:link].as("___rem3"),
            Destination.rem3[:row_id].as("___row_id"),
          )
          manager.from(Destination.rem3)
          manager.join(Destination.rem2).on(Destination.rem2[:link].eq(Destination.rem3[:link_up]))
          manager.join(Destination.rem1).on(Destination.rem1[:link].eq(Destination.rem2[:link_up]))
          manager.where(Destination.rem1[:object].eq(Destination::Rem1::DOCUMENTS_0401003A))
          manager.to_sql
        end

        begin
          sql = ''

          Destination.execute_query(query).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update payments set 
                payments.___rem3 = values_table.___rem3
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                join payments on payments.___row_id = values_table.___row_id
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
