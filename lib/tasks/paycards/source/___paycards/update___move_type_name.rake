namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update___move_type_name do |t|

        def query
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.v_mss_agreements_types[:link].as("___link_type_a"),
            Destination.v_mss_agreements_types[:move_type_name].as("___move_type_name"),
          ])
          manager.from(Destination.v_mss_agreements_types)
        end

        begin
          Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___paycards set 
                ___paycards.___move_type_name = values_table.___move_type_name
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ___paycards.___link_type_a = values_table.___link_type_a
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
