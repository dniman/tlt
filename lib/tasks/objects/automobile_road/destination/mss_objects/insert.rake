namespace :objects do
  namespace :automobile_road do
    namespace :destination do
      namespace :mss_objects do

        task :insert do |t|
          def link_type_query
            Destination.mss_objects_types 
            .project(Destination.mss_objects_types[:link])
            .where(Destination.mss_objects_types[:code].eq("AUTOMOBILE_ROAD"))
          end

          def query
            link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

            select_one = 
              Source.objects
              .project([
                Source.objects[:description],
                Source.objects[:invno],
                Source.buildings[:kadastrno],
                Source.___ids[:row_id],
                Source.___ids[:link_type],
                Source.buildings[:levelname].as("name"),
                Arel.sql("null").as("___house_material"),
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
                Arel.sql("null as ___vri_avtodor"),
                Arel.sql("null as ___klass_avtodor"),
                Arel.sql("null as ___kateg_avtodor"),
                Arel.sql("null as ___group_im"),
              ])
              .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
              .join(Source.___ids).on(Source.___ids[:id].eq(Source.objects[:id]).and(Source.___ids[:table_id].eq(Source::Objects.table_id)))
              .join(Source.buildings).on(Source.buildings[:objects_id].eq(Source.objects[:id]))
              .join(Source.buildtypes, Arel::Nodes::OuterJoin).on(Source.buildtypes[:id].eq(Source.buildings[:buildtypes_id]))
              .join(Source.buildmaterials, Arel::Nodes::OuterJoin).on(Source.buildmaterials[:id].eq(Source.buildings[:buildmaterial_id]))
              .join(Source.spr_zhkh_vid, Arel::Nodes::OuterJoin).on(Source.spr_zhkh_vid[:id].eq(Source.objects[:vid_zhkh_id]))
              .join(Source.monumenttypes, Arel::Nodes::OuterJoin).on(Source.monumenttypes[:id].eq(Source.objects[:mntype_id]))
              .where(Source.___ids[:link_type].eq(link_type))
            
            select_two = 
              Source.objects
              .project([
                Source.objects[:description],
                Source.objects[:invno],
                Source.enginf[:kadastrno],
                Source.___ids[:row_id],
                Source.___ids[:link_type],
                Source.enginf[:name],
                Arel.sql(
                  "ltrim(rtrim(
                      replace(replace([enginf].[material], char(9), ''), char(10), '')
                    ))"
                ).as("___house_material"),
                Source.enginf[:isrealestate],
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
                      replace(replace([enginf].[purpose], char(9), ''), char(10), '')
                    ))"
                ).as("___unmovable_used"),
                Source.road_use[:name].as("___vri_avtodor"),
                Source.road_classes[:name].as("___klass_avtodor"),
                Source.road_category[:name].as("___kateg_avtodor"),
                Source.infgroups[:name].as("___group_im"),
              ])
              .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
              .join(Source.___ids).on(Source.___ids[:id].eq(Source.objects[:id]).and(Source.___ids[:table_id].eq(Source::Objects.table_id)))
              .join(Source.enginf).on(Source.enginf[:objects_id].eq(Source.objects[:id]))
              .join(Source.enginftypes, Arel::Nodes::OuterJoin).on(Source.enginftypes[:id].eq(Source.enginf[:enginftypes_id]))
              .join(Source.spr_zhkh_vid, Arel::Nodes::OuterJoin).on(Source.spr_zhkh_vid[:id].eq(Source.objects[:vid_zhkh_id]))
              .join(Source.monumenttypes, Arel::Nodes::OuterJoin).on(Source.monumenttypes[:id].eq(Source.objects[:mntype_id]))
              .join(Source.road_use, Arel::Nodes::OuterJoin).on(Source.road_use[:id].eq(Source.enginf[:road_use_id]))
              .join(Source.road_classes, Arel::Nodes::OuterJoin).on(Source.road_classes[:id].eq(Source.enginf[:road_classes_id]))
              .join(Source.road_category, Arel::Nodes::OuterJoin).on(Source.road_category[:id].eq(Source.enginf[:road_category_id]))
              .join(Source.infgroups, Arel::Nodes::OuterJoin).on(Source.infgroups[:id].eq(Source.enginf[:infgroups_id]))
              .where(Source.___ids[:link_type].eq(link_type))
              
            union = select_one.union :all, select_two
            union_table = Arel::Table.new :union_table

            manager = Arel::SelectManager.new
            manager.project(Arel.star)
            manager.from(union_table.create_table_alias(union,:union_table))
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
                  ___kadastrno:
                    begin 
                      if (row["kadastrno"]&.index('/').nil? & row["kadastrno"]&.index('-').nil?) 
                        row["kadastrno"]&.strip 
                      else 
                        nil
                      end
                    end,
                  ___house_material: row["___house_material"]&.strip,
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
                  ___vri_avtodor: row["___vri_avtodor"]&.strip,
                  ___klass_avtodor: row["___klass_avtodor"]&.strip,
                  ___kateg_avtodor: row["___kateg_avtodor"]&.strip,
                  ___group_im: row["___group_im"]&.strip,
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
