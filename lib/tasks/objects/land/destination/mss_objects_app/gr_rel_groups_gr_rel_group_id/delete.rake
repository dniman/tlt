namespace :objects do
  namespace :land do
    namespace :destination do
      namespace :mss_objects_app do
        namespace :gr_rel_groups_gr_rel_group_id do
          
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
                .where(Destination.mss_objects_types[:code].eq('LAND')
                  .and(Destination.mss_objects_params[:code].eq('GR_REL_GROUPS_GR_REL_GROUP_ID')))

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
