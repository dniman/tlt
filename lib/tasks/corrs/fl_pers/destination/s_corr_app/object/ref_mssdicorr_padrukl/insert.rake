namespace :corrs do
  namespace :fl_pers do
    namespace :destination do
      namespace :s_corr_app do
        namespace :object do
          namespace :ref_mssdicorr_padrukl do

            task :insert do |t|

              def query
                attributes = [
                  "country_name = isnull(countries.name, '')",
                  "post_index = isnull(address.postcode, '')",
                  "region_name = isnull(regions.name, '')",
                  "rayon_name = isnull(provincearea.name, '')",
                  "city_name = case when townnames.name like 'г.%' then townnames.name end",
                  "npunkt_name = case 
                    when townnames.name like 'г.%' then isnull(townarea.name, '') 
                    when townnames.name = townarea.name then isnull(townnames.name, '') 
                    else isnull(townnames.name, '') + ' ' + isnull(townarea.name, '')	
                  end",
                  "street_name = convert(varchar(75),isnull(streets.name, ''))",
                  "house_num = convert(varchar(35), isnull(coalesce(cast(address.house as varchar), cast(address.nbuild as varchar), ''),'') + isnull(coalesce(cast(address.house_char as varchar), cast(address.nbuild_char as varchar),''),''))",
                  "corp_num = convert(varchar(35), isnull(cast(address.tank as varchar),''))",
                  "room_num = convert(varchar(35), isnull(coalesce(cast(address.room as varchar), cast(address.appartment as varchar), cast(address.chamber as varchar),''),'') + isnull(cast(address.room_char as varchar),''))",
                  "addition = isnull(address.addon, '')",
                  "no_view_townarea = address.no_view_townarea"
                ]
                
                Source.address
                .project(
                  Source.___ids[:link],
                  attributes.join(', '),
                  Arel.sql("#{ Destination::SCorrApp::REF_MSSDICORR_PADRUKL }").as("object"),
                )
                .join(Source.countries, Arel::Nodes::OuterJoin).on(Source.countries[:id].eq(Source.address[:country_id]))
                .join(Source.regions, Arel::Nodes::OuterJoin).on(Source.regions[:id].eq(Source.address[:regions_id]))
                .join(Source.provincearea, Arel::Nodes::OuterJoin).on(Source.provincearea[:id].eq(Source.address[:provincearea_id]))
                .join(Source.townnames, Arel::Nodes::OuterJoin).on(Source.townnames[:id].eq(Source.address[:townnames_id]))
                .join(Source.streets, Arel::Nodes::OuterJoin).on(Source.streets[:id].eq(Source.address[:streets_id]))
                .join(Source.townarea, Arel::Nodes::OuterJoin).on(Source.townarea[:id].eq(Source.address[:townarea_id]))
                .join(Source.microarea, Arel::Nodes::OuterJoin).on(Source.microarea[:id].eq(Source.address[:microarea_id]))
                .join(Source.clients).on(Source.clients[:address_id].eq(Source.address[:id]))
                .join(Source.___ids).on(Source.___ids[:id].eq(Source.clients[:id]).and(Source.___ids[:table_id].eq(Source::Clients.table_id)))
                .join(Source.client_types, Arel::Nodes::OuterJoin).on(Source.client_types[:id].eq(Source.clients[:client_types_id]))
                  .where(Source.client_types[:name].eq('Физическое лицо')
                    .and(Source.clients[:address_f_id].not_eq(nil))
                  )
              end

              begin
                sql = ""
                insert = []
                condition =<<~SQL
                  s_corr_app.link_up = values_table.link_up
                    and s_corr_app.value = values_table.value
                    and s_corr_app.object = values_table.object
                SQL

                Source.execute_query(query.to_sql).each_slice(1000) do |rows|
                  rows.each do |row|
                    full_addr = [
                      row["country_name"].to_s.strip,
                      row["post_index"].to_s.strip,
                      row["region_name"].to_s.strip,
                      row["rayon_name"].to_s.strip,
                      '',
                      row["city_name"].to_s.strip,
                      '',
                      row["street_name"].to_s.strip,
                      row["house_num"].to_s.strip,
                      row["corp_num"].to_s.strip,
                      row["room_num"].to_s.strip,
                      row["addition"].to_s.strip
                    ]
                    insert << {
                      link_up: row['link'],
                      value: full_addr.join(','),
                      object: row["object"],
                    }
                  end
                  sql = Destination::SCorrApp.insert_query(rows: insert, condition: condition)
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
