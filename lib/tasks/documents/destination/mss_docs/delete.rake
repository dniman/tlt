namespace :documents do
  namespace :destination do
    namespace :mss_docs do

      task :delete do |t|
        def query
          condition = Destination.___del_ids.create_on(
            Destination.___del_ids[:row_id].eq(Destination.mss_docs[:row_id])
            .and(Destination.___del_ids[:table_id].eq(Source::Documents.table_id))
          )
          source = Arel::Nodes::JoinSource.new(Destination.mss_docs,
                                               [Destination.mss_docs.create_join(Destination.___del_ids, condition)])
          
          manager = Arel::DeleteManager.new Database.destination_engine
          manager.from(source)
          manager.to_sql
        end

        begin
          Destination.execute_query(query)
          
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
