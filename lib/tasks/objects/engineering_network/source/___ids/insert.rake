namespace :objects do
  namespace :engineering_network do
    namespace:source do
      namespace :___ids do

        task :insert do |t|
          def link_type_query
            Destination.mss_objects_types 
            .project(Destination.mss_objects_types[:link])
            .where(Destination.mss_objects_types[:code].eq("ENGINEERING_NETWORK"))
          end

          def query
            link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]

            select_one = 
              Source.objects
              .project([
                Arel.sql("table_id = #{Source::Objects.table_id}"),
                Source.objects[:id],
                Arel.sql("#{link_type}").as("link_type"),
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
                Arel.sql("#{link_type}").as("link_type"),
                Arel.sql("row_id = newid()")
              ])
              .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
              .join(Source.enginf).on(Source.enginf[:objects_id].eq(Source.objects[:id]))
              .join(Source.enginftypes, Arel::Nodes::OuterJoin).on(Source.enginftypes[:id].eq(Source.enginf[:enginftypes_id]))
              .join(Source.infgroups, Arel::Nodes::OuterJoin).on(Source.infgroups[:id].eq(Source.enginf[:infgroups_id]))
              .where(Source.objtypes[:name].eq('Инженерная инфраструктура')
                .and(Source.infgroups[:name].in([
                  'Водоотведение',
                  'Газоснабжение',
                  'Теплоснабжение',
                  'Электроснабжение',
                  'Водоснабжение',
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
                ]))
              )

            union = select_one.union :all, select_two
            union_table = Arel::Table.new :union_table

            subquery = Arel::SelectManager.new Database.source_engine
            subquery.project(Arel.star)
            subquery.from(Source.___ids)
            subquery.where(
              Source.___ids[:id].eq(union_table[:id])
              .and(Source.___ids[:table_id].eq(Source::Objects.table_id))
            )
             
            select_manager = Arel::SelectManager.new
            select_manager.project([
              union_table[:table_id],
              union_table[:id],
              union_table[:link_type],
              union_table[:row_id],
            ])
            select_manager.from(union_table.create_table_alias(union,:union_table))
            select_manager.where(subquery.exists.not)
            
            source = Arel::Nodes::JoinSource.new(select_manager,[])

            insert_manager = Arel::InsertManager.new Database.source_engine
            insert_manager.columns << Source.___ids[:table_id] 
            insert_manager.columns << Source.___ids[:id]
            insert_manager.columns << Source.___ids[:link_type]
            insert_manager.columns << Source.___ids[:row_id]
            insert_manager.into(Source.___ids)
            insert_manager.select(source)
            insert_manager.to_sql
          end

          begin
            Source.execute_query(query).do

            Rake.info "Задача '#{ t }' успешно выполнена."
          rescue StandardError => e
            Rake.error "Ошибка при выполнении задачи '#{ t }' - #{e}."
            Rake.info "Текст запроса \"#{ query }\""

            exit
          end
        end

      end
    end
  end
end
