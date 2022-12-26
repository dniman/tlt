namespace :corrs do
  namespace :fl_pers do
    namespace :destination do
      namespace :mss_viw_ocval_simple do
        namespace :corr_inn_hist do

          task :insert do |t|
            def link_app_prop_query
              Destination.mss_objcorr_props
              .project(Destination.mss_objcorr_props[:link])
              .where(Destination.mss_objcorr_props[:code].eq('CORR_INN_HIST'))
            end

            def query
              link_app_prop = Destination.execute_query(link_app_prop_query.to_sql).entries.first["link"]
              actual_date = Time.now.strftime("%Y%m%d")

              subquery = Arel::SelectManager.new Database.destination_engine
              subquery.project(Arel.star)
              subquery.from(Destination.mss_viw_ocval_simple)
              subquery.where(
                Destination.mss_viw_ocval_simple[:link_app_up].eq(Destination.mss_objcorr[:link])
                .and(Destination.mss_viw_ocval_simple[:link_app_prop].eq(link_app_prop))
                .and(Destination.mss_viw_ocval_simple[:varchar].eq(Destination.s_corr[:inn]))
                .and(Destination.mss_viw_ocval_simple[:actual_date].eq(actual_date))
              )
               
              corr_types = Arel::Table.new("s_corr").alias("corr_types")
              varchar =
                Arel::Nodes::Addition.new(
                  Arel::Nodes::Addition.new(Arel.sql("'<varchar>'"), Destination.s_corr[:inn]), Arel.sql("'</varchar>'")
                )
              select_manager = Arel::SelectManager.new
              select_manager.project([
                Destination.mss_objcorr[:link].as("link_app_up"),
                Arel.sql("#{ link_app_prop }").as("link_app_prop"),
                Destination.s_corr[:inn].as("varchar"),
                varchar.as("value"),
                Arel.sql("'#{ actual_date }'").as("actual_date"),
              ])
              select_manager.from(Destination.mss_objcorr)
              select_manager.join(Destination.s_corr).on(Destination.s_corr[:link].eq(Destination.mss_objcorr[:link_s_corr]))
              select_manager.join(Destination.t_corr_dict).on(Destination.t_corr_dict[:corr].eq(Destination.s_corr[:link]))
              select_manager.join(corr_types).on(corr_types[:link].eq(Destination.t_corr_dict[:corr_dict]))
              select_manager.where(
                Destination.t_corr_dict[:object].eq(Destination::TCorrDict::REFERENCE_CORR_TYPE)
                .and(corr_types[:inn].eq('FL_PERS'))
                .and(Destination.s_corr[:inn].not_eq(nil))
                .and(subquery.exists.not)
              ) 
              source = Arel::Nodes::JoinSource.new(select_manager,[])

              insert_manager = Arel::InsertManager.new Database.destination_engine
              insert_manager.columns << Destination.mss_viw_ocval_simple[:link_app_up] 
              insert_manager.columns << Destination.mss_viw_ocval_simple[:link_app_prop] 
              insert_manager.columns << Destination.mss_viw_ocval_simple[:varchar] 
              insert_manager.columns << Destination.mss_viw_ocval_simple[:value] 
              insert_manager.columns << Destination.mss_viw_ocval_simple[:actual_date] 
              insert_manager.into(Destination.mss_viw_ocval_simple)
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
