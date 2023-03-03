namespace :paycards do
  namespace :destination do
    namespace :schedulesum do

      task :delete do |t|
        def query
          condition1 = Destination.schedulesum.create_on(Destination.paycard[:link].eq(Destination.schedulesum[:link_pc]))
          condition2 = Destination.___del_ids.create_on(
            Destination.___del_ids[:row_id].eq(Destination.paycard[:row_id])
            .and(Destination.___del_ids[:table_id].eq(Source::Paycards.table_id))
          )

          source = Arel::Nodes::JoinSource.new(
            Destination.schedulesum, [
              Destination.schedulesum.create_join(Destination.paycard, condition1),
              Destination.paycard.create_join(Destination.___del_ids, condition2),
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
