namespace :payments do
  namespace :destination do
    namespace :t_rem1 do

      task :delete do |t|
        def query
          condition1 = Destination.rem1.create_on(Destination.rem1[:link].eq(Destination.t_rem1[:ref2]))
          condition2 = Destination.___del_ids.create_on(
            Destination.___del_ids[:row_id].eq(Destination.rem1[:row_id])
            .and(Destination.___del_ids[:table_id].eq(Source::Payments.table_id))
          )
          source = Arel::Nodes::JoinSource.new(Destination.t_rem1,
                                               [Destination.t_rem1.create_join(Destination.rem1, condition1),
                                                Destination.rem1.create_join(Destination.___del_ids, condition2)])
          
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
