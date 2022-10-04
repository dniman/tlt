namespace :objects do
  namespace :transport do
    namespace :destination do
      namespace :mss_objects do

        task :insert do |t|
          def link_type_query
            Destination.set_engine!
            query = 
              Destination.mss_objects_types 
              .project(Destination.mss_objects_types[:link])
              .where(Destination.mss_objects_types[:code].eq("TRANSPORT"))
          end

          def query
            link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

            Source.set_engine!

            Source.objects
            .project([
              Source.objects[:description],
              Source.objects[:invno],
              Source.ids[:row_id],
              Source.ids[:link_type],
              Source.transptype[:name].as("___type_transport"),
              Source.brandnames[:name].as("___automaker"),
              Source.colors[:name].as("___color_kuzov"),
              Source.engtype[:name].as("___engine_type"),
              Source.manufacturers[:name].as("___auto_country"),
            ])
            .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
            .join(Source.ids).on(Source.ids[:id].eq(Source.objects[:id]).and(Source.ids[:table_id].eq(Source::Objects.table_id)))
            .join(Source.transport, Arel::Nodes::OuterJoin).on(Source.transport[:objects_id].eq(Source.objects[:id]))
            .join(Source.transptype, Arel::Nodes::OuterJoin).on(Source.transptype[:id].eq(Source.transport[:transptype_id]))
            .join(Source.brandnames, Arel::Nodes::OuterJoin).on(Source.brandnames[:id].eq(Source.transport[:brandnames_id]))
            .join(Source.colors, Arel::Nodes::OuterJoin).on(Source.colors[:id].eq(Source.transport[:ps_color_id]))
            .join(Source.engtype, Arel::Nodes::OuterJoin).on(Source.engtype[:id].eq(Source.transport[:ps_engtype_id]))
            .join(Source.manufacturers, Arel::Nodes::OuterJoin).on(Source.manufacturers[:id].eq(Source.transport[:ps_manufacturer_id]))
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
                  ___type_transport: row["___type_transport"]&.strip,
                  ___automaker: row["___automaker"]&.strip,
                  ___color_kuzov: row["___color_kuzov"]&.strip,
                  ___engine_type: row["___engine_type"]&.strip,
                  ___auto_country: row["___auto_country"]&.strip,
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
