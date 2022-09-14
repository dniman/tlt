namespace :objects do
  namespace :houses_unlife do
    namespace :destination do
      namespace :mss_objects_adr do

        task :delete do |t|
          begin
            Destination.set_engine!
           
            subquery = 
              Destination.mss_objects
              .project(Destination.mss_objects[:link_adr])
              .join(Destination.mss_objects_types)
              .on(Destination.mss_objects_types[:link].eq(Destination.mss_objects[:link_type])
              .and(Destination.mss_objects_types[:code].eq('HOUSES_UNLIFE')))

            manager = Arel::DeleteManager.new(Database.destination_engine)
            manager.from (Destination.mss_objects_adr)
            manager.where(Arel::Nodes::In.new(Destination.mss_objects_adr[:link_up],subquery))

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
