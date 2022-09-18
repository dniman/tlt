namespace :objects do
  namespace :construction do
    namespace :destination do
      namespace :mss_objects do

        task :insert do |t|
          def link_type_query
            Destination.set_engine!
            query = 
              Destination.mss_objects_types 
              .project(Destination.mss_objects_types[:link])
              .where(Destination.mss_objects_types[:code].eq("CONSTRUCTION"))
          end

          def query
            link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

            Source.set_engine!
            select_one = 
              Source.objects
              .project([
                Source.objects[:description],
                Source.objects[:invno],
                Source.buildings[:kadastrno],
                Source.ids[:row_id],
                Source.ids[:link_type],
                Source.buildings[:levelname].as("name"),
                Source.buildmaterials[:name].as("___house_material"),
              ])
              .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
              .join(Source.ids).on(Source.ids[:id].eq(Source.objects[:id]).and(Source.ids[:table_id].eq(Source::Objects.table_id)))
              .join(Source.buildings).on(Source.buildings[:objects_id].eq(Source.objects[:id]))
              .join(Source.buildtypes, Arel::Nodes::OuterJoin).on(Source.buildtypes[:id].eq(Source.buildings[:buildtypes_id]))
              .join(Source.buildmaterials, Arel::Nodes::OuterJoin).on(Source.buildmaterials[:id].eq(Source.buildings[:buildmaterial_id]))
              .where(Source.ids[:link_type].eq(link_type))
            
            select_two = 
              Source.objects
              .project([
                Source.objects[:description],
                Source.objects[:invno],
                Source.enginf[:kadastrno],
                Source.ids[:row_id],
                Source.ids[:link_type],
                Source.enginf[:name],
                Source.enginf[:material].as("___house_material"),
              ])
              .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
              .join(Source.ids).on(Source.ids[:id].eq(Source.objects[:id]).and(Source.ids[:table_id].eq(Source::Objects.table_id)))
              .join(Source.enginf).on(Source.enginf[:objects_id].eq(Source.objects[:id]))
              .join(Source.enginftypes, Arel::Nodes::OuterJoin).on(Source.enginftypes[:id].eq(Source.enginf[:enginftypes_id]))
              .where(Source.ids[:link_type].eq(link_type))
              
            union = select_one.union :all, select_two
            union_table = Arel::Table.new :union_table

            manager = Arel::SelectManager.new
            manager.project(Arel.star)
            manager.from(union_table.create_table_alias(union,:union_table))
          end

          begin
            sql = ""
            insert = []
            sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
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
                  ___kadastrno:
                    begin 
                      if (row["kadastrno"]&.index('/').nil? & row["kadastrno"]&.index('-').nil?) 
                        row["kadastrno"]&.strip 
                      else 
                        nil
                      end
                    end,
                  ___house_material: row["___house_material"]&.strip,
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
