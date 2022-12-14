namespace :objects do
  namespace :movable_other do
    namespace :source do
      namespace :___ids do

        task :update___last_loc_addr do |t|
          def link_type_query(code)
            Destination.set_engine!
            
            Destination.mss_objects_types 
            .project(Destination.mss_objects_types[:link])
            .where(Destination.mss_objects_types[:code].eq(code))
          end

          def query
            link_type = Destination.execute_query(link_type_query("MOVABLE_OTHER").to_sql).entries.first["link"]
            
            attributes = [
              "link = ___ids.link",
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
            .join(Source.property).on(Source.property[:address_id].eq(Source.address[:id]))
            .join(Source.objects).on(Source.objects[:id].eq(Source.property[:objects_id]))
            .join(Source.___ids).on(Source.___ids[:id].eq(Source.objects[:id]).and(Source.___ids[:table_id].eq(Source::Objects.table_id)))
            .where(Source.___ids[:link_type].eq(link_type)
              .and(Source.property[:address_id].not_eq(nil))
            )
          end

          begin
            update = []
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              rows.each do |row|
                full_addr = [
                  row["country_name"].to_s.strip,
                  row["post_index"].to_s.strip,
                  row["region_name"].to_s.strip,
                  row["rayon_name"].to_s.strip,
                  '',
                  row["city_name"].to_s.strip,
                  row["no_view_townarea"] == 'Y' ? '' : row["npunkt_name"].to_s.strip,
                  row["street_name"].to_s.strip
                ]
                full_addr << row["house_num"].to_s.strip  unless row["house_num"].to_s.strip.empty?
                full_addr << row["corp_num"].to_s.strip unless row["corp_num"].to_s.strip.empty?
                full_addr << row["room_num"].to_s.strip unless row["room_num"].to_s.strip.empty?
                full_addr << row["addition"].to_s.strip unless row["addition"].to_s.strip.empty?
              
                update << {
                  link: row["link"],
                  full_addr: full_addr.join(',').match?(/[^,*].*[^,*]/) ? full_addr.join(',').match(/[^,*].*[^,*]/)[0] : ''
                }
              end
              columns = update.map(&:keys).uniq.flatten 
              values_list = Arel::Nodes::ValuesList.new(update.map(&:values))
              
              sql = <<~SQL
                update ___ids set 
                  ___ids.___last_loc_addr = values_table.full_addr
                from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
                where ___ids.link = values_table.link and ___ids.table_id = #{ Source::Objects.table_id }
              SQL
              result = Source.execute_query(sql)
              result.do
              update.clear
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
