namespace :moving_operations do
  namespace :destination do
    namespace :mss_movs do

      task :delete do |t|

        def query
          condition = Destination.___moving_operations.create_on(Destination.___moving_operations[:row_id].eq(Destination.mss_movs[:row_id]))
          source = Arel::Nodes::JoinSource.new(Destination.___moving_operations,
                                               [Destination.___moving_operations.create_join(Destination.mss_movs, condition)])

          manager = Arel::DeleteManager.new Database.destination_engine
          manager.from(source)
        end

        begin
          result = Destination.execute_query(query.to_sql).do
          
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
