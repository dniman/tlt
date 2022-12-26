namespace :corrs do
  namespace :fl_pers do
    namespace :destination do
      namespace :mss_objcorr_docs do

        task :delete do |t|
          def query
            condition1 = Destination.mss_objcorr_docs.create_on(Destination.s_corr[:link].eq(Destination.mss_objcorr_docs[:link_objcorr]))
            condition2 = Destination.___del_ids.create_on(
              Destination.___del_ids[:row_id].eq(Destination.s_corr[:row_id])
              .and(Destination.___del_ids[:table_id].eq(Source::Clients.table_id))
            )

            source = Arel::Nodes::JoinSource.new(
              Destination.mss_objcorr_docs, [
                Destination.mss_objcorr_docs.create_join(Destination.s_corr, condition1),
                Destination.s_corr.create_join(Destination.___del_ids, condition2),
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
