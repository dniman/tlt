namespace :agreements do
  namespace :source do
    namespace :movesets do
      task :update___ground_owner do |t|
        def link_type_query
          Destination.mss_objects_types 
          .project(Destination.mss_objects_types[:link])
          .where(Destination.mss_objects_types[:code].eq("LAND"))
        end

        def query
          link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]
          cte_table = Arel::Table.new(:cte_table)
          
          select_one = 
            Source.moveperiods
            .project(
              Source.moveperiods[:id],
              Source.moveperiods[:moveset_id],
              Source.moveperiods[:prev_moveperiod_id],
            )
            .where(Source.moveperiods[:prev_moveperiod_id].eq(nil))

          select_two = 
            Source.moveperiods
            .project(
              Source.moveperiods[:id],
              Source.moveperiods[:moveset_id],
              Source.moveperiods[:prev_moveperiod_id],
            )
            .join(cte_table).on(cte_table[:id].eq(Source.moveperiods[:prev_moveperiod_id]))

          union = select_one.union :all, select_two
          moveperiods_cte = Arel::Nodes::As.new(cte_table, union)

          Source.movesets
          .project(
            Source.movesets[:id],
            Source.grounds_noknum_own[:name].as("___ground_owner"),
          )
          .distinct
          .with(moveperiods_cte)
          .join(cte_table).on(cte_table[:moveset_id].eq(Source.movesets[:id]))
          .join(Source.moveitems, Arel::Nodes::OuterJoin).on(Source.moveitems[:moveperiod_id].eq(cte_table[:id]))
          .join(Source.___ids).on(Source.___ids[:id].eq(Source.moveitems[:object_id]).and(Source.___ids[:table_id].eq(Source::Objects.table_id)))
          .join(Source.grounds).on(Source.grounds[:objects_id].eq(Source.___ids[:id]))
          .join(Source.grounds_noknum_own, Arel::Nodes::OuterJoin).on(Source.grounds_noknum_own[:id].eq(Source.grounds[:ground_owner]))
          .where(Source.___ids[:link_type].eq(link_type))
        end

        begin
          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              columns = rows.map(&:keys).uniq.flatten
              values_list = Arel::Nodes::ValuesList.new(rows.map(&:values))
          
              sql = <<~SQL
                update movesets set 
                  movesets.___ground_owner = values_table.___ground_owner
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
