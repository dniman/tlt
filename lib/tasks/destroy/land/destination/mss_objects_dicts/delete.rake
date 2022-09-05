namespace :destroy do
  namespace :land do
    namespace :destination do
      namespace :mss_objects_dicts do
        task :delete do |t|
          begin
            Destination.set_engine!
            subquery = 
              Destination.mss_objects_dicts
              .project(Destination.mss_objects_dicts[:link])
              .distinct
              .join(Destination.mss_objects).on(Destination.mss_objects[:link_cad_quorter].eq(Destination.mss_objects_dicts[:link]))
              .join(Destination.mss_objects_types, Arel::Nodes::OuterJoin)
              .on(Destination.mss_objects_types[:link].eq(Destination.mss_objects[:link_type]))
              .where(Destination.mss_objects_types[:code].eq('LAND'))
              .where(
                Destination.mss_objects_dicts
                .project(Destination.mss_objects_dicts[:link])
                .distinct
                .join(Destination.mss_objects).on(Destination.mss_objects[:link_cad_quorter].eq(Destination.mss_objects_dicts[:link]))
                .join(Destination.mss_objects_types, Arel::Nodes::OuterJoin)
                .on(Destination.mss_objects_types[:link].eq(Destination.mss_objects[:link_type]))
                .where(Destination.mss_objects_types[:code].eq('LAND').not).exists.not
              )

            manager = Arel::DeleteManager.new(Database.destination_engine)
            manager.from (Destination.mss_objects_dicts)
            manager.where(Arel::Nodes::In.new(Destination.mss_objects_dicts[:link],subquery))

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
