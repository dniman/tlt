namespace :dictionaries do
  namespace :dictionary_bank do
    namespace :destination do
      namespace :s_bank do

        task :delete do |t|

          def query
            condition = Destination.___del_ids.create_on(
              Destination.___del_ids[:row_id].eq(Destination.s_bank[:row_id])
              .and(Destination.___del_ids[:table_id].eq(Source::ClientBanks.table_id))
            )
            source = Arel::Nodes::JoinSource.new(Destination.s_bank,
                                                 [Destination.s_bank.create_join(Destination.___del_ids, condition)])

            manager = Arel::DeleteManager.new Database.destination_engine
            manager.from(source)
            manager.to_sql
          end

          begin
            result = Destination.execute_query(query).do
            
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
