namespace :objects do
  namespace :automobile_road do
    namespace :destination do
      namespace :mss_objects_app do
        namespace :link_param do
          namespace :add_hist do
            
            task :delete do |t|
              def query
                condition1 = Destination.mss_objects.create_on(Destination.mss_objects[:link].eq(Destination.mss_objects_app[:link_up]))
                condition2 = Destination.___del_ids.create_on(
                  Destination.___del_ids[:row_id].eq(Destination.mss_objects[:row_id])
                  .and(Destination.___del_ids[:table_id].eq(Source::Objects.table_id))
                )
                condition3 = Destination.mss_objects_params.create_on(Destination.mss_objects_params[:link].eq(Destination.mss_objects_app[:link_param]))

                source = Arel::Nodes::JoinSource.new(
                  Destination.mss_objects_app, [
                    Destination.mss_objects_app.create_join(Destination.mss_objects, condition1),
                    Destination.mss_objects.create_join(Destination.___del_ids, condition2),
                    Destination.mss_objects_app.create_join(Destination.mss_objects_params, condition3),
                  ]
                )
            
                manager = Arel::DeleteManager.new Database.destination_engine
                manager.from(source)
                manager.where(Destination.mss_objects_params[:code].eq('ADD_HIST'))
                manager.to_sql
              end

              begin
                subquery = 
                  Destination.mss_objects_app
                  .project(Destination.mss_objects_app[:link])
                  .distinct
                  .join(Destination.mss_objects).on(Destination.mss_objects[:link].eq(Destination.mss_objects_app[:link_up]))
                  .join(Destination.mss_objects_types, Arel::Nodes::OuterJoin)
                    .on(Destination.mss_objects_types[:link].eq(Destination.mss_objects[:link_type]))
                  .join(Destination.mss_objects_params, Arel::Nodes::OuterJoin)
                    .on(Destination.mss_objects_params[:link].eq(Destination.mss_objects_app[:link_param]))
                  .where(Destination.mss_objects_types[:code].eq('AUTOMOBILE_ROAD')
                    .and(Destination.mss_objects_params[:code].eq('ADD_HIST')))

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
