namespace :objects do
  namespace :unlife_room do
    namespace :destination do
      namespace :mss_objects_struelem do

        task :delete do |t|
          def link_type_query(code)
            Destination.mss_objects_types 
            .project(Destination.mss_objects_types[:link])
            .where(Destination.mss_objects_types[:code].eq(code))
          end

          def query
            link_type = Destination.execute_query(link_type_query('UNLIFE_ROOM').to_sql).entries.first["link"]

            condition1 = Destination.mss_objects_struelem.create_on(Destination.mss_objects[:link].eq(Destination.mss_objects_struelem[:link_up]))
            condition2 = Destination.___del_ids.create_on(
              Destination.___del_ids[:row_id].eq(Destination.mss_objects[:row_id])
              .and(Destination.___del_ids[:table_id].eq(Source::Objects.table_id))
            )

            source = Arel::Nodes::JoinSource.new(
              Destination.mss_objects_struelem, [
                Destination.mss_objects_struelem.create_join(Destination.mss_objects, condition1),
                Destination.mss_objects.create_join(Destination.___del_ids, condition2),
              ]
            )
            
            manager = Arel::DeleteManager.new Database.destination_engine
            manager.from(source)
            manager.where(Destination.mss_objects[:link_type].eq(link_type))
            manager.to_sql
          end

          begin
            Destination.execute_query(query).do

            Rake.info "Задача '#{ t }' успешно выполнена."
          rescue StandardError => e
            Rake.error "Ошибка при выполнении задачи '#{ t }' - #{e}."
            Rake.info "Текст запроса \"#{ query }\""

            exit
          end
        end

      end
    end
  end
end
