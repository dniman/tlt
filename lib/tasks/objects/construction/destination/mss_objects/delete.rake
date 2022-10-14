namespace :objects do
  namespace :construction do
    namespace :destination do
      namespace :mss_objects do

        task :delete do |t|
          begin
            subquery = 
              Destination.mss_objects
              .project(Destination.mss_objects[:link])
              .join(Destination.mss_objects_types)
              .on(Destination.mss_objects_types[:link].eq(Destination.mss_objects[:link_type])
              .and(Destination.mss_objects_types[:code].eq('CONSTRUCTION')))

            manager = Arel::DeleteManager.new(Database.destination_engine)
            manager.from (Destination.mss_objects)
            manager.where(Arel::Nodes::In.new(Destination.mss_objects[:link],subquery))

            Destination.execute_query(manager.to_sql).do
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
