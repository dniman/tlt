namespace :corrs do
  namespace :ul do
    namespace :destination do
      namespace :mss_viw_ocval_dictstxt do
        namespace :liquidation_yl do

          task :insert do |t|
            def link_app_prop_query
              Destination.mss_objcorr_props
              .project(Destination.mss_objcorr_props[:link])
              .where(Destination.mss_objcorr_props[:code].eq('LIQUIDATION_YL'))
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
              yes = Destination.execute_query(link_dict_query(link_app_prop, 'Да')).entries.first["link"]

              is_liquidated =
                Arel::Nodes::Case.new
                .when(Source.organisations[:liquidated].eq('Y')).then(yes)

              select1 =
                Source.clients
                .project([
                  Source.___ids[:___link].as("link_app_up"),
                  Arel.sql("#{ link_app_prop }").as("link_app_prop"),
                  is_liquidated.as("link_dict"),
                  Source.clients[:exists_end].as("actual_date"),
                ])
                .join(Source.___ids).on(Source.___ids[:id].eq(Source.clients[:id]).and(Source.___ids[:table_id].eq(Source::Clients.table_id)))
                .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
                .join(Source.organisations, Arel::Nodes::OuterJoin).on(Source.organisations[:clients_id].eq(Source.clients[:id]))
                .where(Source.client_types[:name].eq('Юридическое лицо')
                  .and(
                    Source.organisations[:liquidated].not_eq(nil)
                    .or(Source.organisations[:liquidated].not_eq('N'))
                  )
                )
              
              select2 = 
                Source.clients
                .project([
                  Source.___ids[:___link].as("link_app_up"),
                  Arel.sql("#{ link_app_prop }").as("link_app_prop"),
                  is_liquidated.as("link_dict"),
                  Source.objects[:exists_end].as("actual_date"),
                ])
                .join(Source.___ids).on(Source.___ids[:id].eq(Source.clients[:id]).and(Source.___ids[:table_id].eq(Source::Clients.table_id)))
                .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
                .join(Source.organisations, Arel::Nodes::OuterJoin).on(Source.organisations[:clients_id].eq(Source.clients[:id]))
                .join(Source.objects).on(Source.objects[:id].eq(Source.organisations[:objects_id]))
                .where(Source.client_types[:name].eq('Юридическое лицо')
                  .and(
                    Source.objects[:exists_end].not_eq(nil)
                  )
                )

                union = Arel::Nodes::Union.new(select1, select2)
                union_table = Arel::Table.new :union_table
                
                select_manager = Arel::SelectManager.new
                select_manager.project([
                  union_table[:link_app_up],
                  union_table[:link_app_prop],
                  union_table[:link_dict],
                  union_table[:actual_date],
                ])
                select_manager.distinct
                select_manager.from(union_table.create_table_alias(union,:union_table))
                select_manager
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
                    actual_date: row["actual_date"],
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
