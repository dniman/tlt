namespace :corrs do
  namespace :ul do
    namespace :destination do
      namespace :mss_objcorr_app do
        namespace :corr_inn_hist do

          task :delete do |t|
            def link_prop_query
              Destination.mss_objcorr_props
              .project(Destination.mss_objcorr_props[:link])
              .where(Destination.mss_objcorr_props[:code].eq('CORR_INN_HIST'))
            end

            def query
              link_prop = Destination.execute_query(link_prop_query.to_sql).entries.first["link"]

              condition1 = Destination.mss_objcorr_app.create_on(Destination.mss_objcorr[:link].eq(Destination.mss_objcorr_app[:link_up]))
              condition2 = Destination.mss_objcorr.create_on(Destination.s_corr[:link].eq(Destination.mss_objcorr[:link_s_corr]))
              condition3 = Destination.___del_ids.create_on(
                Destination.___del_ids[:row_id].eq(Destination.s_corr[:row_id])
                .and(Destination.___del_ids[:table_id].eq(Source::Clients.table_id))
              )
              source = Arel::Nodes::JoinSource.new(
                Destination.mss_objcorr_app, [
                  Destination.mss_objcorr_app.create_join(Destination.mss_objcorr, condition1),
                  Destination.mss_objcorr.create_join(Destination.s_corr, condition2),
                  Destination.s_corr.create_join(Destination.___del_ids, condition3)
                ]
              )
              
              manager = Arel::DeleteManager.new Database.destination_engine
              manager.from(source)
              manager.where(Destination.mss_objcorr_app[:link_prop].eq(link_prop))
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
