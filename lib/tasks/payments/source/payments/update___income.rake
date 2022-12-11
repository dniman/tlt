namespace :payments do
  namespace :source do
    namespace :payments do

      task :update___income do |t|
        def query
          manager = Arel::SelectManager.new Database.destination_engine
          manager.project(
            Destination.s_kbk[:link].as("___income"),
            Destination.s_kbk[:code].as("___income_code"),
          )
          manager.from(Destination.s_kbk)
          manager.where(Destination.s_kbk[:object].eq(Destination::SKbk::DICTIONARY_KBK_INC))
          manager.to_sql
        end

        begin
          sql = ''

          Destination.execute_query(query).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update payments set 
                payments.___income = values_table.___income
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where payments.___income_code = values_table.___income_code
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
