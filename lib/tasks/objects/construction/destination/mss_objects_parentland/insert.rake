namespace :objects do
  namespace :construction do
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
            link_construction_type = Destination.execute_query(link_type_query('CONSTRUCTION').to_sql).entries.first["link"]

            land_manager = Arel::SelectManager.new(Database.source_engine)
            land_manager.project([
              Source.___ids[:link].as("link_parent"),
              Source.grounds[:id],
            ])
            land_manager.from(Source.___ids)
            land_manager.join(Source.grounds).on(Source.grounds[:objects_id].eq(Source.___ids[:id]))
            land_manager.where(
              Source.___ids[:table_id].eq(Source::Objects.table_id)
                .and(Source.___ids[:link_type].eq(link_land_type))
            )
                      
            build_manager = Arel::SelectManager.new(Database.source_engine)
            build_manager.project([
              Source.___ids[:link].as("link_child"),
              Source.buildings[:id],
            ])
            build_manager.from(Source.___ids)
            build_manager.join(Source.buildings).on(Source.buildings[:objects_id].eq(Source.___ids[:id]))
            build_manager.where(
              Source.___ids[:table_id].eq(Source::Objects.table_id)
                .and(Source.___ids[:link_type].eq(link_construction_type))
            )
            
            construction_manager = Arel::SelectManager.new(Database.source_engine)
            construction_manager.project([
              Source.___ids[:link].as("link_child"),
              Source.enginf[:id],
            ])
            construction_manager.from(Source.___ids)
            construction_manager.join(Source.enginf).on(Source.enginf[:objects_id].eq(Source.___ids[:id]))
            construction_manager.where(
              Source.___ids[:table_id].eq(Source::Objects.table_id)
                .and(Source.___ids[:link_type].eq(link_construction_type))
            )

            o1 = land_manager.as('o1')
            o2 = build_manager.as('o2')
            o3 = construction_manager.as('o3')

            manager_one = Arel::SelectManager.new(Database.source_engine)
            manager_one.distinct
            manager_one.project([
              o1[:link_parent],
              o2[:link_child],
            ])
            manager_one.from(Source.links_grounds_buildings)
            manager_one.join(o1).on(o1[:id].eq(Source.links_grounds_buildings[:grounds_id]))
            manager_one.join(o2).on(o2[:id].eq(Source.links_grounds_buildings[:buildings_id]))
            
            manager_two = Arel::SelectManager.new(Database.source_engine)
            manager_two.distinct
            manager_two.project([
              o1[:link_parent],
              o3[:link_child],
            ])
            manager_two.from(Source.links_grounds_enginf)
            manager_two.join(o1).on(o1[:id].eq(Source.links_grounds_enginf[:grounds_id]))
            manager_two.join(o3).on(o3[:id].eq(Source.links_grounds_enginf[:enginf_id]))

            union = Arel::Nodes::Union.new(manager_one, manager_two)
            t = union.as('t')

            manager = Arel::SelectManager.new(t)
            manager.distinct
            manager.project(Arel.star)
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
