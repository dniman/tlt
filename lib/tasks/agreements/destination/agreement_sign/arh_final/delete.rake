namespace :agreements do
  namespace :destination do
    namespace :agreement_sign do
      namespace :arh_final do

        task :delete do |t|
          def stat_query
            manager = Arel::SelectManager.new Database.destination_engine
            manager.project(Destination.s_note[:link])
            manager.from(Destination.s_note)
            manager.where(Destination.s_note[:code].eq('ARH_FINAL'))
            manager.to_sql
          end

          def query
            stat = Destination.execute_query(stat_query).entries.first["link"]

            condition1 = Destination.agreement_sign.create_on(Destination.agreement[:link].eq(Destination.agreement_sign[:link_up]))
            condition2 = Destination.___del_ids.create_on(
              Destination.___del_ids[:row_id].eq(Destination.agreement[:row_id])
              .and(Destination.___del_ids[:table_id].eq(Source::Agreements.table_id))
            )
            source = Arel::Nodes::JoinSource.new(
              Destination.agreement_sign, [
                Destination.agreement_sign.create_join(Destination.agreement, condition1),
                Destination.agreement.create_join(Destination.___del_ids, condition2)
              ]
            )
            
            manager = Arel::DeleteManager.new Database.destination_engine
            manager.from(source)
            manager.where(Destination.agreement_sign[:stat].eq(stat))
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
