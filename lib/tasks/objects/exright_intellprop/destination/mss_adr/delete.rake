namespace :objects do
  namespace :exright_intellprop do
    namespace :destination do
      namespace :mss_adr do
        
        task :delete do |t|
          begin
            subquery = 
              Destination.mss_objects
              .project(Destination.mss_objects[:link_adr])
              .join(Destination.mss_objects_types)
              .on(Destination.mss_objects_types[:link].eq(Destination.mss_objects[:link_type])
              .and(Destination.mss_objects_types[:code].eq('EXRIGHT_INTELLPROP')))

            manager = Arel::DeleteManager.new(Database.destination_engine)
            manager.from (Destination.mss_adr)
            manager.where(Arel::Nodes::In.new(Destination.mss_adr[:link],subquery))

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
