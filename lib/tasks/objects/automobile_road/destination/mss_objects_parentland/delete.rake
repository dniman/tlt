namespace :objects do
  namespace :automobile_road do
    namespace :destination do
      namespace :mss_objects_parentland do

        task :delete do |t|
          begin
            subquery = 
              Destination.mss_objects
              .project(Destination.mss_objects[:link])
              .join(Destination.mss_objects_types, Arel::Nodes::OuterJoin).on(Destination.mss_objects_types[:link].eq(Destination.mss_objects[:link_type]))
              .where(Destination.mss_objects_types[:code].eq('AUTOMOBILE_ROAD'))

            manager = Arel::DeleteManager.new(Database.destination_engine)
            manager.from (Destination.mss_objects_parentland)
            manager.where(Destination.mss_objects_parentland[:link_child].in(subquery))
                
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