namespace :charges do
  namespace :destination do
    namespace :isk_etap_charges do

      task :delete do |t|
        def query
          condition = Destination.___del_ids.create_on(
            Destination.___del_ids[:link].eq(Destination.isk_etap_charges[:link_charge])
            .and(Destination.___del_ids[:table_id].eq(Source::Charges___.table_id))
          )
          source = Arel::Nodes::JoinSource.new(Destination.isk_etap_charges,
                                               [Destination.isk_etap_charges.create_join(Destination.___del_ids, condition)])
          
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
