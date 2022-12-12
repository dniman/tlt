namespace :agreements do
  namespace :source do
    namespace :___ids do

      task :update___object do |t|
        def query
          object = Arel::Nodes::NamedFunction.new("dbo.obj_id", [ Destination.v_mss_agreements_types[:obj_code] ], 'object')
          manager = Arel::SelectManager.new Database.destination_engine
          manager.project(
            Destination.v_mss_agreements_types[:link].as("link_type"),
            object.as("___object"),
          )
          manager.from(Destination.v_mss_agreements_types)
          manager.to_sql
        end

        begin
          sql = ''

          Destination.execute_query(query).each_slice(1000) do |rows|
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update ___ids set 
                ___ids.___object = values_table.___object
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where ___ids.link_type = values_table.link_type
                and ___ids.table_id = #{ Source::Agreements.table_id }
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
