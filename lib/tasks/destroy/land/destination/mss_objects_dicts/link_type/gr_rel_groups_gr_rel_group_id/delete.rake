namespace :destroy do
  namespace :land do
    namespace :destination do
      namespace :mss_objects_dicts do
        namespace :link_type do
          namespace :gr_rel_groups_gr_rel_group_id do

            task :delete do |t|
              def link_param_query(code)
                Destination.set_engine!
                query = 
                  Destination.mss_objects_params
                  .project(Destination.mss_objects_params[:link])
                  .where(Destination.mss_objects_params[:code].eq(code))
              end

              begin
                link_param = Destination.execute_query(link_param_query('GR_REL_GROUPS_GR_REL_GROUP_ID').to_sql).entries.first["link"]

                Destination.set_engine!
                subquery = 
                  Destination.mss_objects_dicts
                  .project(Destination.mss_objects_dicts[:link])
                  .distinct
                  .where(Destination.mss_objects_dicts[:link_dict].eq(link_param)
                    .and(
                      Destination.mss_objects_app
                      .project(Destination.mss_objects_app[:link_dict])
                      .distinct
                      .join(Destination.mss_objects).on(Destination.mss_objects[:link].eq(Destination.mss_objects_app[:link_up]))
                      .join(Destination.mss_objects_types, Arel::Nodes::OuterJoin)
                        .on(Destination.mss_objects_types[:link].eq(Destination.mss_objects[:link_type]))
                      .where(Destination.mss_objects_types[:code].not_eq('LAND')
                        .and(Destination.mss_objects_app[:link_param].eq(link_param))
                      ).exists.not
                    )
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
  end
end
