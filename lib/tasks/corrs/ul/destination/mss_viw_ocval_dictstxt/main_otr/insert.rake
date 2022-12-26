namespace :corrs do
  namespace :ul do
    namespace :destination do
      namespace :mss_viw_ocval_dictstxt do
        namespace :main_otr do

          task :insert do |t|
            def link_app_prop_query
              Destination.mss_objcorr_props
              .project(Destination.mss_objcorr_props[:link])
              .where(Destination.mss_objcorr_props[:code].eq('MAIN_OTR'))
            end
            
            def link_dict_query(link_prop, value)
              Destination.mss_objcorr_dictsimptext
              .project(Destination.mss_objcorr_dictsimptext[:link])
              .where(
                Destination.mss_objcorr_dictsimptext[:link_prop].eq(link_prop)
                .and(Destination.mss_objcorr_dictsimptext[:value].eq(value))
              )
              .to_sql
            end

            def query
              link_app_prop = Destination.execute_query(link_app_prop_query.to_sql).entries.first["link"]
              main_otrs_ids = Source.___ids.alias("main_otrs_ids")

              Source.clients
              .project([
                Source.___ids[:___link].as("link_app_up"),
                Arel.sql("#{ link_app_prop }").as("link_app_prop"),
                main_otrs_ids[:link].as("link_dict"),
              ])
              .join(Source.___ids).on(Source.___ids[:id].eq(Source.clients[:id]).and(Source.___ids[:table_id].eq(Source::Clients.table_id)))
              .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
              .join(Source.___main_otrs, Arel::Nodes::OuterJoin).on(Source.___main_otrs[:name].eq(Source.___ids[:___main_otr_name]))
              .join(main_otrs_ids).on(main_otrs_ids[:id].eq(Source.___main_otrs[:id]).and(main_otrs_ids[:table_id].eq(Source::MainOtrs.table_id)))
              .join(Source.organisations, Arel::Nodes::OuterJoin).on(Source.organisations[:clients_id].eq(Source.clients[:id]))
              .where(Source.client_types[:name].eq('Юридическое лицо')
                .and(Source.___ids[:___main_otr_name].not_eq(nil))
              )
            end

            begin
              sql = ""
              insert = []
              condition =<<~SQL
                mss_viw_ocval_dictstxt.link_app_up = values_table.link_app_up
                  and mss_viw_ocval_dictstxt.link_app_prop = values_table.link_app_prop
                  and mss_viw_ocval_dictstxt.link_dict = values_table.link_dict
              SQL

              Source.execute_query(query.to_sql).each_slice(1000) do |rows|
                rows.each do |row|
                  insert << {
                    link_app_up: row["link_app_up"],
                    link_app_prop: row["link_app_prop"],
                    link_dict: row["link_dict"],
                  }
                end

                sql = Destination::MssViwOcvalDictstxt.insert_query(rows: insert, condition: condition)
                result = Destination.execute_query(sql)
                result.do
                insert.clear
                sql.clear
              end

              Rake.info "Задача '#{ t }' успешно выполнена."
            rescue StandardError => e
              Rake.error "Ошибка при выполнении задачи '#{ t }' - #{e}."
              Rake.info "Текст запроса \"#{ sql }\""

              exit
            end
          end

        end
      end
    end
  end
end
