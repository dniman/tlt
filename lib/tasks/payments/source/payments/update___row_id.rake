namespace :payments do
  namespace :source do
    namespace :payments do

      task :update___row_id do |t|
        def query
          manager = Arel::SelectManager.new Database.source_engine
          manager.project(
            Source.payments[:id],
            Source.___ids[:row_id].as("___row_id"),
          )
          manager.from(Source.payments)
          manager.join(Source.___ids).on(
            Source.___ids[:id].eq(Source.payments[:id])
            .and(Source.___ids[:table_id].eq(Source::Payments.table_id))
          )
          manager.to_sql
        end

        begin
          sql = ''

          Source.execute_query(query).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update payments set 
                payments.___row_id = values_table.___row_id
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where payments.id = values_table.id
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
