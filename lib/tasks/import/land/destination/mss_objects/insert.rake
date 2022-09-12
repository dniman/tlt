namespace :import do
  namespace :land do
    namespace :destination do
      namespace :mss_objects do
        task :insert do |t|
          def link_type_query
            Destination.set_engine!
            query = 
              Destination.mss_objects_types 
              .project(Destination.mss_objects_types[:link])
              .where(Destination.mss_objects_types[:code].eq("LAND"))
          end

          def query
            link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

            Source.set_engine!
            query = 
              Source.objects
              .project([
                Source.objects[:description],
                Source.objects[:invno],
                Source.grounds[:oktmo],
                Source.grounds[:kadastrno],
                Source.ids[:row_id],
                Source.ids[:link_type],
                Source.grounds_noknum_own[:name].as("___land_ownership"),
                Source.grounds[:in_transition],
                Source.groundtypes[:name].as("___land_kateg"),
                Source.grounds[:prec_doc].as("___land_used"),
                Source.gr_fact_release[:name].as("___unmovable_used_new"),
              ])
              .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
              .join(Source.ids).on(Source.ids[:id].eq(Source.objects[:id]).and(Source.ids[:table_id].eq(Source::Objects.table_id)))
              .join(Source.grounds).on(Source.grounds[:objects_id].eq(Source.objects[:id]))
              .join(Source.groundtypes, Arel::Nodes::OuterJoin).on(Source.groundtypes[:id].eq(Source.grounds[:groundtypes_id]))
              .join(Source.grounds_noknum_own, Arel::Nodes::OuterJoin).on(Source.grounds_noknum_own[:id].eq(Source.grounds[:ground_owner]))
              .join(Source.gr_fact_release, Arel::Nodes::OuterJoin).on(Source.gr_fact_release[:id].eq(Source.grounds[:gr_fact_release_id]))
              .where(Source.ids[:link_type].eq(link_type))
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
                  ___oktmo: row["oktmo"]&.strip,
                  ___kadastrno:
                    begin 
                      if (row["kadastrno"]&.index('/').nil? & row["kadastrno"]&.index('-').nil?) 
                        row["kadastrno"]&.strip 
                      else 
                        nil
                      end
                    end,
                  ___land_ownership: row["___land_ownership"]&.strip,
                  ___transition_rf_ms: row["in_transition"]&.strip == 'Y' ? 'Да' : 'Нет',
                  ___land_kateg: row["___land_kateg"]&.strip,
                  ___land_used: row["___land_used"]&.strip,
                  ___unmovable_used_new: row["___unmovable_used_new"]&.strip,
                }
              end
              sql = Destination::MssObjects.insert_query(rows: insert, condition: "mss_objects.row_id = values_table.row_id")
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
