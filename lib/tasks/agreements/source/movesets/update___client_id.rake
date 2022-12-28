namespace :agreements do
  namespace :source do
    namespace :movesets do

      task :update___client_id do |t|
        def docrole_id_query
          Source.docroles
          .project(Source.docroles[:id])
          .where(Source.docroles[:name].eq("Основной документ"))
        end
        
        def link_agreement_type_query(name)
          Destination.v_mss_agreements_types 
          .project(Destination.v_mss_agreements_types[:link])
          .where(Destination.v_mss_agreements_types[:name].eq(name))
        end

        # Балансодержание, договор аренды балансодержателей, безвозмездное пользование балансодержателей
        def query1
          cte_table = Arel::Table.new(:cte_table)
          ___ids2 = Source.___ids.alias('___ids2')
          basebuildings = Source.buildings.alias('basebuildings')
          basebuildings1 = Source.buildings.alias('basebuildings1')
          
          select_one = 
            Source.moveperiods
            .project(
              Source.objtypes[:name].as("objtypes_name"),
              ___ids2[:link_type],
              Source.moveperiods[:id],
              Source.movetype[:name].as("movetype_name"),
              Source.moveperiods[:sincedate],
              Source.moveperiods[:enddate],
              Source.moveperiods[:moveset_id],
              Source.movesets[:client_id],
              Source.moveitems[:object_id],
              Arel.sql('0').as("level"),
              Source.movesets[:___agreement_id],
            )
            .join(Source.movesets).on(Source.movesets[:id].eq(Source.moveperiods[:moveset_id]))
            .join(Source.movetype).on(Source.movetype[:id].eq(Source.movesets[:movetype_id]))
            .join(Source.moveitems).on(Source.moveitems[:moveperiod_id].eq(Source.moveperiods[:id]))
            .join(___ids2).on(
              ___ids2[:id].eq(Source.moveitems[:object_id])
                .and(___ids2[:table_id].eq(Source::Objects.table_id))
            )
            .join(Source.objects).on(Source.objects[:id].eq(___ids2[:id]))
            .join(Source.objtypes).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
            .where(Source.movetype[:name].eq('Балансодержание'))
          
          type1 = 'Договор безвозмездного пользования на имущество (балансодержателей)'
          type2 = 'Договор аренды недвижимого имущества (аренда балансодержателей)'
          type3 = 'Договор аренды движимого имущества (аренда балансодержателей)'
          
          link_type1 = Destination.execute_query(link_agreement_type_query(type1).to_sql).entries.first["link"]
          link_type2 = Destination.execute_query(link_agreement_type_query(type2).to_sql).entries.first["link"]
          link_type3 = Destination.execute_query(link_agreement_type_query(type3).to_sql).entries.first["link"]
          
          enddate = Arel::Nodes::NamedFunction.new('isnull', [ cte_table[:enddate], Arel.sql("'99991231'") ])
          between = Arel::Nodes::Between.new(
            Source.moveperiods[:sincedate],
            Arel::Nodes::And.new([
              cte_table[:sincedate],
              enddate
            ])
          )
          
          select_two = 
            Source.moveperiods
            .project([
              Source.objtypes[:name].as("objtypes_name"),
              ___ids2[:link_type],
              Source.moveperiods[:id],
              Source.movetype[:name].as("movetype_name"),
              Source.moveperiods[:sincedate],
              Source.moveperiods[:enddate],
              Source.moveperiods[:moveset_id],
              cte_table[:client_id],
              Source.moveitems[:object_id],
              Arel.sql('cte_table.level + 1').as("level"),
              Source.movesets[:___agreement_id],
            ])
            .join(Source.movesets).on(Source.movesets[:id].eq(Source.moveperiods[:moveset_id]))
            .join(Source.movetype).on(Source.movetype[:id].eq(Source.movesets[:movetype_id]))
            .join(Source.moveitems).on(Source.moveitems[:moveperiod_id].eq(Source.moveperiods[:id]))
            .join(cte_table).on(
              between
              .and(cte_table[:level].eq(0))
              .and(cte_table[:object_id].eq(Source.moveitems[:object_id]))
            )
            .join(Source.___ids).on(
              Source.___ids[:id].eq(Source.movesets[:___agreement_id])
              .and(Source.___ids[:table_id].eq(Source::Agreements.table_id))
            )
            .join(___ids2).on(
              ___ids2[:id].eq(Source.moveitems[:object_id])
                .and(___ids2[:table_id].eq(Source::Objects.table_id))
            )
            .join(Source.objects).on(Source.objects[:id].eq(___ids2[:id]))
            .join(Source.objtypes).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
            .where(Source.___ids[:link_type].in([link_type1, link_type2, link_type3]))
          
          select_three = 
            Source.moveperiods
            .project(
              Source.objtypes[:name].as("objtypes_name"),
              ___ids2[:link_type],
              Source.moveperiods[:id],
              Source.movetype[:name].as("movetype_name"),
              Source.moveperiods[:sincedate],
              Source.moveperiods[:enddate],
              Source.moveperiods[:moveset_id],
              cte_table[:client_id],
              Source.moveitems[:object_id],
              Arel.sql('cte_table.level + 1').as("level"),
              Source.movesets[:___agreement_id],
            )
            .join(Source.movesets).on(Source.movesets[:id].eq(Source.moveperiods[:moveset_id]))
            .join(Source.movetype).on(Source.movetype[:id].eq(Source.movesets[:movetype_id]))
            .join(Source.moveitems).on(Source.moveitems[:moveperiod_id].eq(Source.moveperiods[:id]))
            .join(Source.buildings).on(Source.buildings[:objects_id].eq(Source.moveitems[:object_id]))
            .join(basebuildings).on(basebuildings[:id].eq(Source.buildings[:basebuilding]))
            .join(cte_table).on(
              between
              .and(cte_table[:level].eq(0))
              .and(cte_table[:object_id].eq(basebuildings[:objects_id]))
            )
            .join(Source.___ids).on(
              Source.___ids[:id].eq(Source.movesets[:___agreement_id])
              .and(Source.___ids[:table_id].eq(Source::Agreements.table_id))
            )
            .join(___ids2).on(
              ___ids2[:id].eq(Source.moveitems[:object_id])
                .and(___ids2[:table_id].eq(Source::Objects.table_id))
            )
            .join(Source.objects).on(Source.objects[:id].eq(___ids2[:id]))
            .join(Source.objtypes).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
            .where(Source.___ids[:link_type].in([link_type1, link_type2, link_type3]))
          
          select_four = 
            Source.moveperiods
            .project(
              Source.objtypes[:name].as("objtypes_name"),
              ___ids2[:link_type],
              Source.moveperiods[:id],
              Source.movetype[:name].as("movetype_name"),
              Source.moveperiods[:sincedate],
              Source.moveperiods[:enddate],
              Source.moveperiods[:moveset_id],
              cte_table[:client_id],
              Source.moveitems[:object_id],
              Arel.sql('cte_table.level + 1').as("level"),
              Source.movesets[:___agreement_id],
            )
            .join(Source.movesets).on(Source.movesets[:id].eq(Source.moveperiods[:moveset_id]))
            .join(Source.movetype).on(Source.movetype[:id].eq(Source.movesets[:movetype_id]))
            .join(Source.moveitems).on(Source.moveitems[:moveperiod_id].eq(Source.moveperiods[:id]))
            .join(Source.buildings).on(Source.buildings[:objects_id].eq(Source.moveitems[:object_id]))
            .join(basebuildings).on(basebuildings[:id].eq(Source.buildings[:basebuilding]))
            .join(basebuildings1).on(basebuildings1[:id].eq(basebuildings[:basebuilding]))
            .join(cte_table).on(
              between
              .and(cte_table[:level].eq(0))
              .and(cte_table[:object_id].eq(basebuildings1[:objects_id]))
            )
            .join(Source.___ids).on(
              Source.___ids[:id].eq(Source.movesets[:___agreement_id])
              .and(Source.___ids[:table_id].eq(Source::Agreements.table_id))
            )
            .join(___ids2).on(
              ___ids2[:id].eq(Source.moveitems[:object_id])
                .and(___ids2[:table_id].eq(Source::Objects.table_id))
            )
            .join(Source.objects).on(Source.objects[:id].eq(___ids2[:id]))
            .join(Source.objtypes).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
            .where(Source.___ids[:link_type].in([link_type1, link_type2, link_type3]))

          union =
            Arel::Nodes::UnionAll.new(
              Arel::Nodes::UnionAll.new(
                Arel::Nodes::UnionAll.new(select_one, select_two), select_three
              ), select_four
            )
          
          moveperiods_cte = Arel::Nodes::As.new(cte_table, union)

          Source.movesets
          .project(
            Source.movesets[:id],
            cte_table[:client_id].as("___client_id"),
          )
          .distinct
          .with(moveperiods_cte)
          .join(cte_table).on(cte_table[:moveset_id].eq(Source.movesets[:id]))
          .where(cte_table[:level].eq(1))
        end

        # Остальные
        def query2
          Source.movesets
          .project(
            Source.movesets[:id],
            Arel.sql(Destination.link_mo.to_s).as("___client_id"),
          )
          .join(Source.movetype).on(Source.movetype[:id].eq(Source.movesets[:movetype_id]))
          .where(Source.movetype[:name].not_in(['Безв.польз.балансодержателей', 'Аренда балансодержателей']))
        end

        begin
          sql =<<~SQL
            if object_id('tempdb..#client_ids') is not null drop table #client_ids
            create table #client_ids(id int, ___client_id int)
            insert into #client_ids(id, ___client_id)
            #{query2.to_sql}

            ;#{query1.to_sql.gsub('SELECT DISTINCT [movesets].[id], [cte_table].[client_id] AS ___client_id', 'insert into #client_ids(id, ___client_id) SELECT DISTINCT [movesets].[id], [cte_table].[client_id] AS ___client_id')}
            
            update movesets
              set movesets.___client_id = #client_ids.___client_id 
            from movesets
              join #client_ids on #client_ids.id = movesets.id

            drop table #client_ids
          SQL

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
