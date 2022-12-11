namespace :charges do
  namespace :destination do
    namespace :___charge_save do

      task :update_ccorr1 do |t|
        def query
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.s_corr[:link],
            Destination.s_corr[:inn],
          ])
          manager.from(Destination.s_corr)
          manager.where(Destination.s_corr[:object].eq(Destination::SCorr::DICTIONARY_CORR))
        end

        begin
          Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___charge_save set 
                ___charge_save.ccorr1 = values_table.inn
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ___charge_save.___corr1 = values_table.link
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
