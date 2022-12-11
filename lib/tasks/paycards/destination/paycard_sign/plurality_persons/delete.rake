namespace :paycards do
  namespace :destination do
    namespace :paycard do

      task :delete1 do |t|
        def query
          condition = Destination.___del_ids.create_on(
            Destination.___del_ids[:link].eq(Destination.paycard[:link])
            .and(Destination.___del_ids[:table_id].eq(Source::Paycards.table_id))
          )
          source = Arel::Nodes::JoinSource.new(Destination.paycard,
                                               [Destination.paycard.create_join(Destination.___del_ids, condition)])
          
          manager = Arel::DeleteManager.new Database.destination_engine
          manager.from(source)
          manager.where(Destination.paycard[:link_up].eq(nil))
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
