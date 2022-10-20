namespace :objects do
  namespace :houses_life do
    namespace :destination do
      namespace :mss_objects_parentland do

        task :insert do |t|
          def link_type_query(code)
            Destination.mss_objects_types 
            .project(Destination.mss_objects_types[:link])
            .where(Destination.mss_objects_types[:code].eq(code))
          end

          def query
            link_land_type = Destination.execute_query(link_type_query('LAND').to_sql).entries.first["link"]
            link_houses_life_type = Destination.execute_query(link_type_query('HOUSES_LIFE').to_sql).entries.first["link"]

            land_manager = Arel::SelectManager.new(Database.source_engine)
            land_manager.project([
              Source.ids[:link].as("link_parent"),
              Source.grounds[:id],
            ])
            land_manager.from(Source.ids)
            land_manager.join(Source.grounds).on(Source.grounds[:objects_id].eq(Source.ids[:id]))
            land_manager.where(
              Source.ids[:table_id].eq(Source::Objects.table_id)
                .and(Source.ids[:link_type].eq(link_land_type))
            )
                      
            build_manager = Arel::SelectManager.new(Database.source_engine)
            build_manager.project([
              Source.ids[:link].as("link_child"),
              Source.buildings[:id],
            ])
            build_manager.from(Source.ids)
            build_manager.join(Source.buildings).on(Source.buildings[:objects_id].eq(Source.ids[:id]))
            build_manager.where(
              Source.ids[:table_id].eq(Source::Objects.table_id)
                .and(Source.ids[:link_type].eq(link_houses_life_type))
            )
            
            o1 = land_manager.as('o1')
            o2 = build_manager.as('o2')

            manager = Arel::SelectManager.new(Database.source_engine)
            manager.distinct
            manager.project([
              o1[:link_parent],
              o2[:link_child],
            ])
            manager.from(Source.links_grounds_buildings)
            manager.join(o1).on(o1[:id].eq(Source.links_grounds_buildings[:grounds_id]))
            manager.join(o2).on(o2[:id].eq(Source.links_grounds_buildings[:buildings_id]))
          end

          begin
            sql = ""
            insert = []
            sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              rows.each do |row|
                insert << {
                  link_parent: row["link_parent"],
                  link_child: row["link_child"],
                  row_id: Arel.sql('newid()'),
                }
              end

              condition =<<~SQL
                mss_objects_parentland.link_parent = values_table.link_parent
                  and mss_objects_parentland.link_child = values_table.link_child
              SQL
              
              sql = Destination::MssObjectsParentland.insert_query(rows: insert, condition: condition)
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