namespace :corrs do
  namespace :fl_pers do
    namespace :destination do
      namespace :mss_viw_ocval_scorrapp do
        namespace :sca_email do

          task :insert do |t|
            def link_app_prop_query
              Destination.mss_objcorr_props
              .project(Destination.mss_objcorr_props[:link])
              .where(Destination.mss_objcorr_props[:code].eq('SCA_EMAIL'))
            end

            def query
              link_app_prop = Destination.execute_query(link_app_prop_query.to_sql).entries.first["link"]

              subquery = Arel::SelectManager.new Database.destination_engine
              subquery.project(Arel.star)
              subquery.from(Destination.mss_viw_ocval_scorrapp)
              subquery.where(
                Destination.mss_viw_ocval_scorrapp[:link_app_up].eq(Destination.mss_objcorr[:link])
                .and(Destination.mss_viw_ocval_scorrapp[:link_app_prop].eq(link_app_prop))
                .and(Destination.mss_viw_ocval_scorrapp[:varchar].eq(Destination.s_corr_app[:value]))
              )
               
              select_manager = Arel::SelectManager.new
              select_manager.project([
                Destination.mss_objcorr[:link].as("link_app_up"),
                Arel.sql("#{ link_app_prop }").as("link_app_prop"),
                Destination.s_corr_app[:value].as("varchar"),
              ])
              select_manager.from(Destination.s_corr_app)
              select_manager.join(Destination.mss_objcorr).on(Destination.mss_objcorr[:link_s_corr].eq(Destination.s_corr_app[:link_up]))
              select_manager.where(
                Destination.s_corr_app[:object].eq(Destination::SCorrApp::MSS_PERSON_IP_EMAIL)
                .and(subquery.exists.not)
              ) 
              source = Arel::Nodes::JoinSource.new(select_manager,[])

              insert_manager = Arel::InsertManager.new Database.destination_engine
              insert_manager.columns << Destination.mss_viw_ocval_scorrapp[:link_app_up] 
              insert_manager.columns << Destination.mss_viw_ocval_scorrapp[:link_app_prop] 
              insert_manager.columns << Destination.mss_viw_ocval_scorrapp[:varchar] 
              insert_manager.into(Destination.mss_viw_ocval_scorrapp)
              insert_manager.select(source)
              insert_manager.to_sql
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
