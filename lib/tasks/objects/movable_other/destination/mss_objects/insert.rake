namespace :objects do
  namespace :movable_other do
    namespace :destination do
      namespace :mss_objects do

        task :insert do |t|
          def link_type_query
            Destination.mss_objects_types 
            .project(Destination.mss_objects_types[:link])
            .where(Destination.mss_objects_types[:code].eq("MOVABLE_OTHER"))
          end

          def query
            link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]
            name = Arel::Nodes::Concat.new(Source.propnames[:name], ' ') 
            name = Arel::Nodes::Concat.new(name, Source.property[:model])

            Source.objects
            .project([
              Source.objects[:description],
              Source.objects[:invno],
              Source.___ids[:row_id],
              Source.___ids[:link_type],
              #Source.property[:model].as("name"),
              name.as("name"),
              Source.propnames[:name].as("___dict_name"),
              Source.propgroups[:name].as("___group"),
              Source.propsections[:name].as("___section"),
            ])
            .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
            .join(Source.___ids).on(Source.___ids[:id].eq(Source.objects[:id]).and(Source.___ids[:table_id].eq(Source::Objects.table_id)))
            .join(Source.property).on(Source.property[:objects_id].eq(Source.objects[:id]))
            .join(Source.propnames, Arel::Nodes::OuterJoin).on(Source.propnames[:id].eq(Source.property[:propnames_id]))
            .join(Source.propgroups, Arel::Nodes::OuterJoin).on(Source.propgroups[:id].eq(Source.property[:propgroups_id]))
            .join(Source.propsections, Arel::Nodes::OuterJoin).on(Source.propsections[:id].eq(Source.property[:propsections_id]))
            .where(Source.___ids[:link_type].eq(link_type))
          end

          begin
            sql = ""
            insert = []
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              rows.each do |row|
                insert << {
                  name: (row["name"].nil? || row["name"].strip.empty?) ? row["description"]&.strip : row["name"]&.strip,
                  inventar_num: row["invno"]&.strip,
                  inventar_num_date: nil,
                  link_type: row["link_type"],
                  link_mo: Destination.link_mo,
                  link_oktmo: nil,
                  object: Destination::MssObjects::DICTIONARY_MSS_OBJECTS,
                  row_id: row["row_id"],
                  ___dict_name: row["___dict_name"]&.strip,
                  ___group: row["___group"]&.strip,
                  ___section: row["___section"]&.strip,
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
