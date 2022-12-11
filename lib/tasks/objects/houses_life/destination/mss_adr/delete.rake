namespace :objects do
  namespace :houses_life do
    namespace :destination do
      namespace :mss_adr do

        task :delete do |t|
          def query
            condition1 = Destination.___del_ids.create_on(Destination.mss_adr[:link].eq(Destination.mss_objects[:link_adr]))
            condition2 = Destination.___del_ids.create_on(
              Destination.___del_ids[:row_id].eq(Destination.mss_objects[:row_id])
              .and(Destination.___del_ids[:table_id].eq(Source::Objects.table_id))
            )

            source = Arel::Nodes::JoinSource.new(
              Destination.mss_adr, [
                Destination.mss_adr.create_join(Destination.mss_objects, condition1),
                Destination.mss_objects.create_join(Destination.___del_ids, condition2),
              ]
            )
            
            manager = Arel::DeleteManager.new Database.destination_engine
            manager.from(source)
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
