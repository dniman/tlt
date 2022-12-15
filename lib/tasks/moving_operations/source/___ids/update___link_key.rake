namespace :moving_operations do
  namespace :source do
    namespace :___ids do

      task :update___link_key do |t|

        def query
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.mss_moves_key[:link].as("___link_key"),
            Destination.mss_moves_key[:row_id],
          ])
          manager.from(Destination.mss_moves_key)
        end

        begin
          sql = ""

          Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___ids set 
                ___ids.___link_key = values_table.___link_key
              from ___ids
                join (#{values_list.to_sql}) values_table(#{columns.join(', ')}) on values_table.row_id = ___ids.row_id
              where ___ids.table_id = #{ Source::MovingOperations.table_id }
            SQL

            Source.execute_query(sql).do
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
