namespace :dictionaries do
  namespace :culturial_sense do
    namespace :destination do
      namespace :mss_objects_dicts do

        task :delete do |t|
          def link_param_query(code)
            Destination.set_engine!
            query = 
              Destination.mss_objects_params
              .project(Destination.mss_objects_params[:link])
              .where(Destination.mss_objects_params[:code].eq(code))
          end

          begin
            link_param = Destination.execute_query(link_param_query('CULTURIAL_SENSE').to_sql).entries.first["link"]

            Destination.set_engine!
            subquery = 
              Destination.mss_objects_dicts
              .project(Destination.mss_objects_dicts[:link])
              .distinct
              .where(Destination.mss_objects_dicts[:link_dict].eq(link_param))

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
