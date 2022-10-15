namespace :objects do
  namespace :share do
    namespace :destination do
      namespace :t_corr_dict do
        namespace :reference_corr_type do
          namespace :emmitstock do

            task :delete do |t|
              def link_type_query
                Destination.mss_objects_types 
                .project(Destination.mss_objects_types[:link])
                .where(Destination.mss_objects_types[:code].eq("SHARE"))
              end
              
              def link_corr_type_query(code)
                Destination.s_corr
                .project(Destination.s_corr[:link])
                .where(Destination.s_corr[:inn].eq(code)
                  .and(Destination.s_corr[:object].eq(Destination::SCorr::DICTIONARY_CORR_TYPE))
                )
              end

              def query
                link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

                ids2 = Source.ids.alias('ids2')

                Source.objects
                .project([
                  ids2[:link].as("corr"),
                ])
                .join(Source.ids).on(Source.ids[:id].eq(Source.objects[:id]).and(Source.ids[:table_id].eq(Source::Objects.table_id)))
                .join(Source.objshares).on(Source.objshares[:objects_id].eq(Source.objects[:id]))
                .join(Source.organisations, Arel::Nodes::OuterJoin).on(Source.organisations[:id].eq(Source.objshares[:organisations_id]))
                .join(Source.clients, Arel::Nodes::OuterJoin).on(Source.clients[:id].eq(Source.organisations[:clients_id]))
                .join(ids2, Arel::Nodes::OuterJoin).on(ids2[:id].eq(Source.clients[:id]).and(ids2[:table_id].eq(Source::Clients.table_id)))
                .where(Source.ids[:link_type].eq(link_type))
              end

              begin
                emmitstock = Destination.execute_query(link_corr_type_query('EMMITSTOCK').to_sql).entries.first["link"]
                sql = ""
                sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
                sliced_rows.each do |rows|
                  condition =<<~SQL
                    t_corr_dict.corr_dict = #{ emmitstock }
                      and t_corr_dict.object = #{ Destination::SObjects.obj_id('REFERENCE_CORR_TYPE') }
                  SQL

                  sql = Destination::TCorrDict.delete_query(links: rows.map(&:values), condition: condition)
                  result = Destination.execute_query(sql)
                  result.do
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
end
