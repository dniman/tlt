namespace :moving_operations do
  namespace :source do
    namespace :___ids do

      task :update___is_change_reestr do |t|

        def query
          ___is_change_reestr = 
            Arel::Nodes::Case.new()
            .when(Destination.mss_v_moves_types[:code_group].eq('FROM_REESTR')).then(1)
            .else(0)

          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.mss_v_moves_types[:link],
            ___is_change_reestr.as("___is_change_reestr"),
          ])
          manager.from(Destination.mss_v_moves_types)
          manager.where(Destination.mss_v_moves_types[:code_group].not_eq(nil))
        end

        begin
          Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___ids set 
                ___ids.___is_change_reestr = values_table.___is_change_reestr
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ___ids.link = values_table.link
                and ___ids.table_id = values_table.table_id
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
