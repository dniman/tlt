namespace :corrs do
  namespace :ul do
    namespace :destination do
      namespace :s_corr_app do
        namespace :object do
          namespace :column_dict_corr_phone_boss do

            task :delete do |t|
              def query
                condition1 = Destination.s_corr_app.create_on(Destination.s_corr[:link].eq(Destination.s_corr_app[:link_up]))
                condition2 = Destination.___del_ids.create_on(
                  Destination.___del_ids[:row_id].eq(Destination.s_corr[:row_id])
                  .and(Destination.___del_ids[:table_id].eq(Source::Clients.table_id))
                )
                source = Arel::Nodes::JoinSource.new(
                  Destination.s_corr_app, [
                    Destination.s_corr_app.create_join(Destination.s_corr, condition1),
                    Destination.s_corr.create_join(Destination.___del_ids, condition2)
                  ]
                )
                
                manager = Arel::DeleteManager.new Database.destination_engine
                manager.from(source)
                manager.where(Destination.s_corr_app[:object].eq(Destination::SCorrApp::COLUMN_DICT_CORR_PHONE_BOSS))
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
  end
end
