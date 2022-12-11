namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update___inc_p do |t|

        def query
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.s_kbk[:link].as("___inc_p"),
            Destination.s_kbk[:code].as("cinc_p"),
          ])
          manager.from(Destination.s_kbk)
          manager.where(Destination.s_kbk[:object].eq(Destination::SKbk::DICTIONARY_KBK_INC))
        end

        begin
          Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___paycards set 
                ___paycards.___inc_p = values_table.___inc_p
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ___paycards.cinc_p = values_table.cinc_p
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
