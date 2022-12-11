namespace :objects do
  namespace :unfinished do
    namespace :source do
      namespace :___ids do

        task :update___add_hist do |t|
          def query
            Destination.mss_objects
            .project(
              Destination.mss_objects[:link], 
              Destination.mss_objects_adr[:adr]
            )
            .join(Destination.mss_objects_types).on(Destination.mss_objects_types[:link].eq(Destination.mss_objects[:link_type]))
            .join(Destination.mss_objects_adr).on(Destination.mss_objects_adr[:link_up].eq(Destination.mss_objects[:link_adr]))
            .where(Destination.mss_objects_types[:code].eq('UNFINISHED'))
          end

          begin
            Destination.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update ___ids set 
                  ___ids.___add_hist = values_table.adr
                from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                where ___ids.link = values_table.link and ___ids.table_id = #{ Source::Objects.table_id }
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
end
