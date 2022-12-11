namespace :payments do
  namespace :source do
    namespace :payments do

      task :update___object do |t|
        def object 
          Destination::SObjects.obj_id('DOCUMENTS_0401003A')
        end

        def query
          manager = Arel::SelectManager.new Database.source_engine
          manager.project(
            Source.payments[:id],
            Arel.sql("#{object}").as("___object"),
          )
          manager.from(Source.payments)
          manager.to_sql
        end

        begin
          sql = ''

          Source.execute_query(query).each_slice(1000) do |rows|
          
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update payments set 
                payments.___object = values_table.___object
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
