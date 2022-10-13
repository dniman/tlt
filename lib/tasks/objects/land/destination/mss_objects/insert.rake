namespace :objects do
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
                Arel.sql(
                  "ltrim(rtrim(
                      replace(replace([grounds].[prec_doc], char(9), ''), char(10), '')
                    ))"
                ).as("___land_used"),
                Source.gr_fact_release[:name].as("___unmovable_used_new"),
                Arel.sql(
                  "ltrim(rtrim(
                      replace(replace([grounds_release].[name], char(9), ''), char(10), '')
                    ))"
                ).as("___grounds_release_release_id"),
                Arel.sql(
                  "ltrim(rtrim(
                      replace(replace([gr_rel_groups].[name], char(9), ''), char(10), '')
                    ))"
                ).as("___gr_rel_groups_gr_rel_group_id"),
                Arel.sql(
                  "ltrim(rtrim(
                      replace(replace([target_doc].[name], char(9), ''), char(10), '')
                    ))"
                ).as("___target_doc_target_doc_id"),
                Arel.sql(
                  "ltrim(rtrim(
                      replace(replace([grounds_funk_using].[name], char(9), ''), char(10), '')
                    ))"
                ).as("___grounds_funk_using_grounds_funk_using_id"),
                Source.objects[:is_sign],
                Source.objects[:is_social],
                Source.objects[:is_zhkh],
                Arel.sql(
                  "ltrim(rtrim(
                      replace(replace([spr_zhkh_vid].[name], char(9), ''), char(10), '')
                    ))"
                ).as("___vid_obj_zkx"),
              ])
              .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
              .join(Source.ids).on(Source.ids[:id].eq(Source.objects[:id]).and(Source.ids[:table_id].eq(Source::Objects.table_id)))
              .join(Source.grounds).on(Source.grounds[:objects_id].eq(Source.objects[:id]))
              .join(Source.groundtypes, Arel::Nodes::OuterJoin).on(Source.groundtypes[:id].eq(Source.grounds[:groundtypes_id]))
              .join(Source.grounds_noknum_own, Arel::Nodes::OuterJoin).on(Source.grounds_noknum_own[:id].eq(Source.grounds[:ground_owner]))
              .join(Source.gr_fact_release, Arel::Nodes::OuterJoin).on(Source.gr_fact_release[:id].eq(Source.grounds[:gr_fact_release_id]))
              .join(Source.grounds_release, Arel::Nodes::OuterJoin).on(Source.grounds_release[:id].eq(Source.grounds[:release_id]))
              .join(Source.gr_rel_groups, Arel::Nodes::OuterJoin).on(Source.gr_rel_groups[:id].eq(Source.grounds[:gr_rel_group_id]))
              .join(Source.target_doc, Arel::Nodes::OuterJoin).on(Source.target_doc[:id].eq(Source.grounds[:target_doc_id]))
              .join(Source.grounds_funk_using, Arel::Nodes::OuterJoin).on(Source.grounds_funk_using[:id].eq(Source.grounds[:grounds_funk_using_id]))
              .join(Source.spr_zhkh_vid, Arel::Nodes::OuterJoin).on(Source.spr_zhkh_vid[:id].eq(Source.objects[:vid_zhkh_id]))
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
                  ___grounds_release_release_id: row["___grounds_release_release_id"]&.strip,
                  ___gr_rel_groups_gr_rel_group_id: row["___gr_rel_groups_gr_rel_group_id"]&.strip,
                  ___target_doc_target_doc_id: row["___target_doc_target_doc_id"]&.strip,
                  ___grounds_funk_using_grounds_funk_using_id: row["___grounds_funk_using_grounds_funk_using_id"]&.strip,
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
