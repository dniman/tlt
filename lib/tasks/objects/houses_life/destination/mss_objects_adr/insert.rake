namespace :objects do
  namespace :houses_life do
    namespace :destination do
      namespace :mss_objects_adr do

        task :insert do |t|
          def link_type_query
            Destination.mss_objects_types 
            .project(Destination.mss_objects_types[:link])
            .where(Destination.mss_objects_types[:code].eq("HOUSES_LIFE"))
          end
          
          def query
            link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

            attributes = [
              "___link_adr = ___ids.___link_adr",
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
            .project(attributes.join(', '))
            .join(Source.countries, Arel::Nodes::OuterJoin).on(Source.countries[:id].eq(Source.address[:country_id]))
            .join(Source.regions, Arel::Nodes::OuterJoin).on(Source.regions[:id].eq(Source.address[:regions_id]))
            .join(Source.provincearea, Arel::Nodes::OuterJoin).on(Source.provincearea[:id].eq(Source.address[:provincearea_id]))
            .join(Source.townnames, Arel::Nodes::OuterJoin).on(Source.townnames[:id].eq(Source.address[:townnames_id]))
            .join(Source.streets, Arel::Nodes::OuterJoin).on(Source.streets[:id].eq(Source.address[:streets_id]))
            .join(Source.townarea, Arel::Nodes::OuterJoin).on(Source.townarea[:id].eq(Source.address[:townarea_id]))
            .join(Source.microarea, Arel::Nodes::OuterJoin).on(Source.microarea[:id].eq(Source.address[:microarea_id]))
            .join(Source.objects).on(Source.objects[:address_id].eq(Source.address[:id]))
            .join(Source.___ids).on(Source.___ids[:id].eq(Source.objects[:id]).and(Source.___ids[:table_id].eq(Source::Objects.table_id)))
            .where(Source.___ids[:link_type].eq(link_type))
          end

          begin
            sql = ""
            insert = []
            sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              rows.each do |row|
                full_addr = [
                  row[:country_name].to_s.strip,
                  row[:post_index].to_s.strip,
                  row[:region_name].to_s.strip,
                  row[:rayon_name].to_s.strip,
                  '',
                  row[:city_name].to_s.strip,
                  '',
                  row[:street_name].to_s.strip,
                  row[:house_num].to_s.strip,
                  row[:corp_num].to_s.strip,
                  row[:room_num].to_s.strip,
                  row[:addition].to_s.strip
                ]
                insert << {
                  link_up: row['___link_adr'],
                  adr: full_addr.join(','),
                  country: row['country_name'].to_s.strip,
                  post_index: row['post_index'].to_s.strip[0,6],
                  region: row['region_name'].to_s.strip[0,50],
                  rayon: row['rayon_name'].to_s.strip[0,75],
                  city: row['city_name'].to_s.strip[0,75],
                  npunkt: row['npunkt_name'].to_s.strip[0,75],
                  street: row['street_name'].to_s.strip[0,75],
                  house: row['house_num'].to_s.strip[0,35],
                  corp: row['corp_num'].to_s.strip[0,35],
                  room: row['room_num'].to_s.strip[0,35],
                  addition: row['addition'].to_s.strip[0,350],
                  use_kladr: 1,
                  row_id: Arel.sql('newid()')
                }
              end
              condition =<<~SQL
                mss_objects_adr.link_up = values_table.link_up
              SQL
              sql = Destination::MssObjectsAdr.insert_query(rows: insert, condition: condition)
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
