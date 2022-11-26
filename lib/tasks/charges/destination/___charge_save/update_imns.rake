namespace :charges do
  namespace :destination do
    namespace :___charge_save do
      
      task :update_imns do |t|
        def query
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.s_baccount[:corr],
            Destination.s_baccount[:link],
          ])
          manager.from(Destination.s_baccount)
        end

        begin
          sliced_rows = Destination.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___charge_save set 
                ___charge_save.imns = values_table.corr
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ___charge_save.acc = values_table.link
            SQL

            result = Destination.execute_query(sql)
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
