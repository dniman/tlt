namespace :agreements do
  namespace :source do
    namespace :___agreements do

      task :update___status do |t|

        def query
          Destination.s_note
          .project(
            Destination.s_note[:code].as("___status"),
            Destination.s_note[:value].as("___status_name"),
          )
          .distinct
          .where(Destination.s_note[:object].eq(Destination::SObjects.obj_id('MSS_DICT_STATUSES')))
        end

        begin
          sql = ""

          Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___agreements set 
                ___agreements.___status = values_table.___status
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ___agreements.___status_name = values_table.___status_name
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
