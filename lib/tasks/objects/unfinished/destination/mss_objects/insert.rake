namespace :objects do
  namespace :unfinished do
    namespace :destination do
      namespace :mss_objects do

        task :insert do |t|
          def link_type_query
            Destination.set_engine!
            query = 
              Destination.mss_objects_types 
              .project(Destination.mss_objects_types[:link])
              .where(Destination.mss_objects_types[:code].eq("UNFINISHED"))
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
                Arel.sql(
                  "ltrim(rtrim(
                      replace(replace([buildmaterials].[name], char(9), ''), char(10), '')
                    ))"
                ).as("___house_wall_type"),
                Source.buildings[:isrealestate],
                Source.objects[:is_sign],
                Source.objects[:is_social],
                Source.objects[:is_zhkh],
                Arel.sql(
                  "ltrim(rtrim(
                      replace(replace([spr_zhkh_vid].[name], char(9), ''), char(10), '')
                    ))"
                ).as("___vid_obj_zkx"),
                Source.monumenttypes[:name].as("___culturial_sense"),
                Arel.sql(
                  "ltrim(rtrim(
                      replace(replace([buildings].[purpose], char(9), ''), char(10), '')
                    ))"
                ).as("___unmovable_used"),
              ])
              .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
              .join(Source.ids).on(Source.ids[:id].eq(Source.objects[:id]).and(Source.ids[:table_id].eq(Source::Objects.table_id)))
              .join(Source.buildings).on(Source.buildings[:objects_id].eq(Source.objects[:id]))
              .join(Source.buildtypes, Arel::Nodes::OuterJoin).on(Source.buildtypes[:id].eq(Source.buildings[:buildtypes_id]))
              .join(Source.buildmaterials, Arel::Nodes::OuterJoin).on(Source.buildmaterials[:id].eq(Source.buildings[:buildmaterial_id]))
              .join(Source.spr_zhkh_vid, Arel::Nodes::OuterJoin)
                .on(Source.spr_zhkh_vid[:id].eq(Source.objects[:vid_zhkh_id]))
              .join(Source.monumenttypes, Arel::Nodes::OuterJoin)
                .on(Source.monumenttypes[:id].eq(Source.objects[:mntype_id]))
              .where(Source.ids[:link_type].eq(link_type))
            
            select_two = 
              Source.objects
              .project([
                Source.objects[:description],
                Source.objects[:invno],
                Source.unconstr[:kadastrno],
                Source.ids[:row_id],
                Source.ids[:link_type],
                Source.unconstr[:name].as("name"),
                Arel.sql("null").as("___house_wall_type"),
                Arel.sql("null").as("isrealestate"),
                Source.objects[:is_sign],
                Source.objects[:is_social],
                Source.objects[:is_zhkh],
                Arel.sql(
                  "ltrim(rtrim(
                      replace(replace([spr_zhkh_vid].[name], char(9), ''), char(10), '')
                    ))"
                ).as("___vid_obj_zkx"),
                Source.monumenttypes[:name].as("___culturial_sense"),
                Arel.sql("null").as("___unmovable_used"),
              ])
              .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
              .join(Source.ids).on(Source.ids[:id].eq(Source.objects[:id]).and(Source.ids[:table_id].eq(Source::Objects.table_id)))
              .join(Source.unconstr).on(Source.unconstr[:objects_id].eq(Source.objects[:id]))
              .join(Source.spr_zhkh_vid, Arel::Nodes::OuterJoin)
                .on(Source.spr_zhkh_vid[:id].eq(Source.objects[:vid_zhkh_id]))
              .join(Source.monumenttypes, Arel::Nodes::OuterJoin)
                .on(Source.monumenttypes[:id].eq(Source.objects[:mntype_id]))
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
                  ___house_wall_type: row["___house_wall_type"]&.strip,
                  ___is_immovable: 
                    begin
                      case row["isrealestate"]&.strip 
                      when 'Y' 
                        'Да' 
                      when 'N'
                        'Нет'
                      end
                    end,
                  ___wow_obj: 
                    begin
                      case row["is_sign"]&.strip 
                      when 'Y' 
                        'Да' 
                      when 'N'
                        'Нет'
                      end
                    end,
                  ___soc_zn_obj: 
                    begin
                      case row["is_social"]&.strip
                      when 'Y' 
                        'Да' 
                      when 'N'
                        'Нет'
                      end
                    end,
                  ___obj_zkx: 
                    begin
                      case row["is_zhkh"]&.strip
                      when 'Y' 
                        'Да' 
                      when 'N'
                        'Нет'
                      end
                    end,
                  ___vid_obj_zkx: row["___vid_obj_zkx"]&.strip,
                  ___culturial_sense: row["___culturial_sense"]&.strip,
                  ___unmovable_used: row["___unmovable_used"]&.strip,
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
