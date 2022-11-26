namespace :charges do
  namespace :destination do
    namespace :___charge_save do

      task :update_inc do |t|
        def query
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.s_kbk[:link],
            Destination.s_kbk[:code],
          ])
          manager.from(Destination.s_kbk)
          manager.where(Destination.s_kbk[:object].eq(Destination::SKbk::DICTIONARY_KBK_INC))
        end

        begin
          sliced_rows = Destination.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___charge_save set 
                ___charge_save.inc = values_table.link
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ___charge_save.___cinc = values_table.code
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
