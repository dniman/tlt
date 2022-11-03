namespace :objects do
  namespace :partnership do
    namespace :destination do
      namespace :mss_objects do

        task :insert do |t|
          def link_type_query
            Destination.mss_objects_types 
            .project(Destination.mss_objects_types[:link])
            .where(Destination.mss_objects_types[:code].eq("PARTNERSHIP"))
          end

          def query
            link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

            ___ids2 = Source.___ids.alias('___ids2')

            Source.objects
            .project([
              Source.objects[:description],
              Source.objects[:invno],
              Source.___ids[:row_id],
              Source.___ids[:link_type],
              ___ids2[:link].as("link_corr"),
            ])
            .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
            .join(Source.___ids).on(Source.___ids[:id].eq(Source.objects[:id]).and(Source.___ids[:table_id].eq(Source::Objects.table_id)))
            .join(Source.objshares).on(Source.objshares[:objects_id].eq(Source.objects[:id]))
            .join(Source.organisations, Arel::Nodes::OuterJoin).on(Source.organisations[:id].eq(Source.objshares[:organisations_id]))
            .join(Source.clients, Arel::Nodes::OuterJoin).on(Source.clients[:id].eq(Source.organisations[:clients_id]))
            .join(___ids2, Arel::Nodes::OuterJoin)
              .on(___ids2[:id].eq(Source.clients[:id])
                .and(___ids2[:table_id].eq(Source::Clients.table_id))
              )
            .where(Source.___ids[:link_type].eq(link_type))
          end

          begin
            sql = ""
            insert = []
            sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              rows.each do |row|
                insert << {
                  name: row["description"]&.strip,
                  inventar_num: row["invno"]&.strip,
                  inventar_num_date: nil,
                  link_type: row["link_type"],
                  link_mo: Destination.link_mo,
                  link_oktmo: nil,
                  object: Destination::MssObjects::DICTIONARY_MSS_OBJECTS,
                  row_id: row["row_id"],
                  link_corr: row["link_corr"],
                }
              end

              condition =<<~SQL
                mss_objects.row_id = values_table.row_id
              SQL

              sql = Destination::MssObjects.insert_query(rows: insert, condition: condition)
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
