namespace :objects do
  namespace :partnership do
    namespace :destination do
      namespace :t_corr_dict do
        namespace :reference_corr_type do
          namespace :partnership do

            task :insert do |t|
              def link_type_query
                Destination.mss_objects_types 
                .project(Destination.mss_objects_types[:link])
                .where(Destination.mss_objects_types[:code].eq("PARTNERSHIP"))
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
                partnership = Destination.execute_query(link_corr_type_query('PARTNERSHIP').to_sql).entries.first["link"]

                ids2 = Source.ids.alias('ids2')

                Source.objects
                .project([
                  ids2[:link],
                  Arel.sql(partnership.to_s).as("corr_dict"),
                ])
                .join(Source.ids).on(Source.ids[:id].eq(Source.objects[:id]).and(Source.ids[:table_id].eq(Source::Objects.table_id)))
                .join(Source.objshares).on(Source.objshares[:objects_id].eq(Source.objects[:id]))
                .join(Source.organisations, Arel::Nodes::OuterJoin).on(Source.organisations[:id].eq(Source.objshares[:organisations_id]))
                .join(Source.clients, Arel::Nodes::OuterJoin).on(Source.clients[:id].eq(Source.organisations[:clients_id]))
                .join(ids2, Arel::Nodes::OuterJoin).on(ids2[:id].eq(Source.clients[:id]).and(ids2[:table_id].eq(Source::Clients.table_id)))
                .where(Source.ids[:link_type].eq(link_type))
              end

              begin
                sql = ""
                insert = []
                sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
                sliced_rows.each do |rows|
                  rows.each do |row|
                    insert << {
                      corr_dict: row["corr_dict"],
                      corr: row["link"],
                      object: Destination::TCorrDict::REFERENCE_CORR_TYPE,
                    }
                  end

                  condition =<<~SQL
                    t_corr_dict.corr_dict = values_table.corr_dict
                      and t_corr_dict.corr = values_table.corr
                      and t_corr_dict.object = values_table.object
                  SQL

                  sql = Destination::TCorrDict.insert_query(rows: insert, condition: condition)
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
end
