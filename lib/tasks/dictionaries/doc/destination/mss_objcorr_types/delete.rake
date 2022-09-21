namespace :dictionaries do
  namespace :doc do
    namespace :destination do
      namespace :mss_objcorr_types do

        task :delete do |t|
          def link_base_query
            Destination.set_engine!
            query = 
              Destination.mss_objcorr_types
              .project(Destination.mss_objcorr_types[:link])
              .where(Destination.mss_objcorr_types[:code].eq('doc'))
          end

          begin
            link_base = Destination.execute_query(link_base_query.to_sql).entries.first["link"]

            Destination.set_engine!
            subquery = 
              Destination.mss_objcorr_types
              .project(Destination.mss_objcorr_types[:link])
              .distinct
              .where(Destination.mss_objcorr_types[:link_base].eq(link_base)
                .and(Destination.mss_objcorr_types[:code].matches("dtsaumiToll_%"))
              )

            manager = Arel::DeleteManager.new(Database.destination_engine)
            manager.from (Destination.mss_objcorr_types)
            manager.where(Arel::Nodes::In.new(Destination.mss_objcorr_types[:link], subquery))

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
