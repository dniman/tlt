namespace :objects do
  namespace :exright_intellprop do
    namespace :destination do
      namespace :mss_objects_adr do

        task :insert do |t|
          def link_type_query
            Destination.mss_objects_types 
            .project(Destination.mss_objects_types[:link])
            .where(Destination.mss_objects_types[:code].eq("EXRIGHT_INTELLPROP"))
          end
          
          def query
            link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]
            
            attributes = [
              "___link_adr = ___ids.___link_adr",
              "country_name = 'Российская Федерация'",
              "post_index = null",
              "region_name = 'Самарская обл'",
              "rayon_name = null",
              "city_name = 'Тольятти г'",
              "npunkt_name = null",
              "street_name = null",
              "house_num = null",
              "corp_num = null",
              "room_num = null",
              "addition = null",
            ]
            
            Source.___ids
            .project(attributes.join(', '))
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
