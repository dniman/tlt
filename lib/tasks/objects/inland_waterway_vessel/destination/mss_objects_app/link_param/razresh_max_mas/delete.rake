namespace :objects do
  namespace :inland_waterway_vessel do
    namespace :destination do
      namespace :mss_objects_app do
        namespace :link_param do
          namespace :razresh_max_mas do
            
            task :delete do |t|
              begin
                Destination.set_engine!
                subquery = 
                  Destination.mss_objects_app
                  .project(Destination.mss_objects_app[:link])
                  .distinct
                  .join(Destination.mss_objects).on(Destination.mss_objects[:link].eq(Destination.mss_objects_app[:link_up]))
                  .join(Destination.mss_objects_types, Arel::Nodes::OuterJoin)
                    .on(Destination.mss_objects_types[:link].eq(Destination.mss_objects[:link_type]))
                  .join(Destination.mss_objects_params, Arel::Nodes::OuterJoin)
                    .on(Destination.mss_objects_params[:link].eq(Destination.mss_objects_app[:link_param]))
                  .where(Destination.mss_objects_types[:code].eq('INLAND_WATERWAY_VESSEL')
                    .and(Destination.mss_objects_params[:code].eq('RAZRESH_MAX_MAS')))

                manager = Arel::DeleteManager.new(Database.destination_engine)
                manager.from (Destination.mss_objects_app)
                manager.where(Arel::Nodes::In.new(Destination.mss_objects_app[:link],subquery))

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
  end
end
