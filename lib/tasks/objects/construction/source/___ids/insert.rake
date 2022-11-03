namespace :objects do
  namespace :construction do
    namespace:source do
      namespace :___ids do

        task :insert do |t|
          def link_type_query
            Destination.mss_objects_types 
            .project(Destination.mss_objects_types[:link])
            .where(Destination.mss_objects_types[:code].eq("CONSTRUCTION"))
          end

          def query
            select_one = 
              Source.objects
              .project([
                Arel.sql("table_id = #{Source::Objects.table_id}"),
                Source.objects[:id],
                Arel.sql("row_id = newid()")
              ])
              .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
              .join(Source.buildings).on(Source.buildings[:objects_id].eq(Source.objects[:id]))
              .join(Source.buildtypes, Arel::Nodes::OuterJoin).on(Source.buildtypes[:id].eq(Source.buildings[:buildtypes_id]))
              .where(Source.objtypes[:name].eq('Здания и помещения')
                .and(Source.buildtypes[:name].in(['Сооружение', 'Отд.расположенная площадка', 'Крыльцо'])))

            select_two =
              Source.objects
              .project([
                Arel.sql("table_id = #{Source::Objects.table_id}"),
                Source.objects[:id],
                Arel.sql("row_id = newid()")
              ])
              .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
              .join(Source.enginf).on(Source.enginf[:objects_id].eq(Source.objects[:id]))
              .join(Source.enginftypes, Arel::Nodes::OuterJoin).on(Source.enginftypes[:id].eq(Source.enginf[:enginftypes_id]))
              .join(Source.infgroups, Arel::Nodes::OuterJoin).on(Source.infgroups[:id].eq(Source.enginf[:infgroups_id]))
              .where(Source.objtypes[:name].eq('Инженерная инфраструктура')
                .and(Source.infgroups[:name].in([
                  'Сети',
                  'Сети электроснабжения',
                  'Сети водоснабжения',
                  'Сети теплоснабжения',
                  'Сети канализационные',
                  'Сети газовые',
                  'Сети радиотрансляционные',
                  'Сети телефонные',
                  'Сети бытовой канализации',
                  'Сети ливневой канализации',
                ]).not
              )

            union = select_one.union :all, select_two
            union_table = Arel::Table.new :union_table

            manager = Arel::SelectManager.new
            manager.project(Arel.star)
            manager.from(union_table.create_table_alias(union,:union_table))
          end

          begin
            sql = ""
            insert = []
            link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]
            sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              rows.each do |row|
                insert << {
                  table_id: row["table_id"],
                  id: row["id"],
                  row_id: row["row_id"],
                  link_type: link_type
                }
              end
              sql = Source::Ids.insert_query(rows: insert, condition: "___ids.id = values_table.id and ___ids.table_id = values_table.table_id")
              result = Source.execute_query(sql)
              result.do
              insert.clear
              sql.clear
            end

            Source.execute_query(sql).do
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
