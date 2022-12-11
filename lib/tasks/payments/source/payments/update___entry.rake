namespace :payments do
  namespace :source do
    namespace :payments do

      task :update___entry do |t|
        def query
          manager = Arel::SelectManager.new Database.destination_engine
          manager.project(
            Destination.entry[:link].as("___entry"),
            Destination.entry[:row_id],
          )
          manager.from(Destination.entry)
          manager.where(Destination.entry[:object].eq(Destination::Rem1::DOCUMENTS_0401003A))
          manager.to_sql
        end

        begin
          sql = ''

          Destination.execute_query(query).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update payments set 
                payments.___entry = values_table.___entry
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                join payments on payments.___row_id = values_table.row_id
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
