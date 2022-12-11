namespace :dictionaries do
  namespace :mss_dict_decommission_causes do
    namespace :destination do
      namespace :mss_decommission_causes do

        task :delete do |t|

          def query
            condition = Destination.___del_ids.create_on(
              Destination.___del_ids[:row_id].eq(Destination.mss_decommission_causes[:row_id])
              .and(Destination.___del_ids[:table_id].eq(Source::MssDictDecommissionCauses.table_id))
            )
            source = Arel::Nodes::JoinSource.new(Destination.mss_decommission_causes,
                                                 [Destination.mss_decommission_causes.create_join(Destination.___del_ids, condition)])

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
