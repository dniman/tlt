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

        def query
          cte_table = Arel::Table.new(:cte_table)
          ___ids2 = Source.___ids.alias('___ids2')
          basebuildings = Source.buildings.alias('basebuildings')
          
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
          
          enddate = Arel::Nodes::NamedFunction.new('isnull', [ cte_table[:enddate], '99991231' ])

          select_two = 
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
              Arel.sql(cte_table[:level] + 1).as("level"),
              Source.movesets[:___agreement_id],
            )
            .join(Source.movesets).on(Source.movesets[:id].eq(Source.moveperiods[:moveset_id]))
            .join(Source.movetype).on(Source.movetype[:id].eq(Source.movesets[:movetype_id]))
            .join(Source.moveitems).on(Source.moveitems[:moveperiod_id].eq(Source.moveperiods[:id]))
            .join(cte_table).on(
              Source.moveperiods[:sincedate].between(cte_table[:sincedate], enddate)
              .and(cte_table[:level].eq(0))
              .and(cte_table[:object_id].eq(Source.moveitems[:object_id]))
            )
            .join(Source.___ids).on(
              Source.___ids[:id].eq(Source.movesets[:agreement_id])
              .and(Source.___ids[:table_id].eq(Source::Agreements.table_id))
            )
            .join(___ids2).on(
              ___ids2[:id].eq(Source.moveitems[:object_id])
                .and(___ids2[:table_id].eq(Source::Objects.table_id))
            )
            .join(Source.objects).on(Source.objects[:id].eq(___ids2[:id]))
            .join(Source.objtypes).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
            .where(Source.ids[:link_type].in([link_type1, link_type2, link_type3]))
          
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
              Arel.sql(cte_table[:level] + 1).as("level"),
              Source.movesets[:___agreement_id],
            )
            .join(Source.movesets).on(Source.movesets[:id].eq(Source.moveperiods[:moveset_id]))
            .join(Source.movetype).on(Source.movetype[:id].eq(Source.movesets[:movetype_id]))
            .join(Source.moveitems).on(Source.moveitems[:moveperiod_id].eq(Source.moveperiods[:id]))
            .join(Source.buildings).on(Source.buildings[:objects_id].eq(Source.moveitems[:object_id]))
            .join(basebuildings).on(basebuildings[:id].eq(Source.buildings[:basebuilding]))
            .join(cte_table).on(
              Source.moveperiods[:sincedate].between(cte_table[:sincedate], enddate)
              .and(cte_table[:level].eq(0))
              .and(cte_table[:object_id].eq(basebuildings[:objects_id]))
            )
            .join(Source.___ids).on(
              Source.___ids[:id].eq(Source.movesets[:agreement_id])
              .and(Source.___ids[:table_id].eq(Source::Agreements.table_id))
            )
            .join(___ids2).on(
              ___ids2[:id].eq(Source.moveitems[:object_id])
                .and(___ids2[:table_id].eq(Source::Objects.table_id))
            )
            .join(Source.objects).on(Source.objects[:id].eq(___ids2[:id]))
            .join(Source.objtypes).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
            .where(Source.ids[:link_type].in([link_type1, link_type2, link_type3]))

          union =
            Arel::Nodes::Union.new(
              Arel::Nodes::Union.new(select_one, select_two), select_three
            )

          moveperiods_cte = Arel::Nodes::As.new(cte_table, union)

          Source.movesets
          .project(
            Source.movesets[:id],
            Source.cte_table[:clients_id],
          )
          .distinct
          .with(moveperiods_cte)
          .join(cte_table).on(cte_table[:moveset_id].eq(Source.movesets[:id]))
          .where(cte_table[:level].eq(1))
        end

        begin
          sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
          sliced_rows.each do |rows|
            columns = rows.map(&:keys).uniq.flatten
            values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
        
            sql = <<~SQL
              update movesets set 
                movesets.___client_id = values_table.___client_id
              from(#{values_list.to_sql}) values_table(#{columns.join(', ')})
              where movesets.id = values_table.id  
            SQL

            result = Source.execute_query(sql)
            result.do
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
