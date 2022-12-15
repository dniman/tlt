namespace :moving_operations do
  namespace :source do
    namespace :___moving_operations do
      task :insert do |t|
        def query
          cte_table = Arel::Table.new(:cte_table)
          
          select_one = 
            Source.moveperiods
            .project(
              Source.moveperiods[:id],
              Source.moveperiods[:sincedate],
              Source.moveperiods[:enddate],
              Source.moveperiods[:moveset_id],
              Source.moveperiods[:prev_moveperiod_id],
              Source.moveperiods[:id].as("parent_moveperiod_id"),
            )
            .where(Source.moveperiods[:prev_moveperiod_id].eq(nil))
          
          select_two = 
            Source.moveperiods
            .project([
              Source.moveperiods[:id],
              Source.moveperiods[:sincedate],
              Source.moveperiods[:enddate],
              Source.moveperiods[:moveset_id],
              Source.moveperiods[:prev_moveperiod_id],
              cte_table[:parent_moveperiod_id],
            ])
            .join(cte_table).on(cte_table[:id].eq(Source.moveperiods[:prev_moveperiod_id]))

          union = Arel::Nodes::UnionAll.new(select_one, select_two)
          moveperiods_cte = Arel::Nodes::As.new(cte_table, union)
                
          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project(Source.___paycards[:id])
          manager.from(Source.___paycards)
          manager.where(
            Source.___paycards[:moveperiod_id].eq(cte_table[:parent_moveperiod_id])
            .and(Source.___paycards[:moveset_id].eq(Source.movesets[:id]))
            .and(Source.___paycards[:prev_moveperiod_id].eq(nil))
          )
          manager.order(Source.___paycards[:sincedate].asc)
          manager.take(1)
          
          Source.movesets
            .project(
              Source.movetype[:name].as("movetype_name"),
              cte_table[:sincedate],
              cte_table[:enddate],
              cte_table[:id].as("moveperiod_id"),
              cte_table[:prev_moveperiod_id],
              cte_table[:parent_moveperiod_id],
              Source.movesets[:id].as("moveset_id"),
              Source.movesets[:client_id],
              Source.moveitems[:id].as("moveitem_id"),
              Source.movesets[:docset_id],
              Source.movesets[:___agreement_id],
              manager.as("___paycard_id"),
              Source.transferbasis[:name].as("transferbasis_name"),
            )
            .distinct
            .with(moveperiods_cte)
            .join(cte_table, Arel::Nodes::OuterJoin).on(cte_table[:moveset_id].eq(Source.movesets[:id]))
            .join(Source.moveitems, Arel::Nodes::OuterJoin).on(Source.moveitems[:moveperiod_id].eq(cte_table[:id]))
            .join(Source.movetype, Arel::Nodes::OuterJoin).on(Source.movetype[:id].eq(Source.movesets[:movetype_id]))
            .join(Source.___paycards, Arel::Nodes::OuterJoin).on(
              Source.___paycards[:___agreement_id].eq(Source.movesets[:___agreement_id])
              .and(Source.___paycards[:moveset_id].eq(Source.movesets[:id]))
              .and(
                Arel::Nodes::NamedFunction.new('isnull', [ Source.___paycards[:moveperiod_id], Arel.sql("0") ]).eq(
                  Arel::Nodes::NamedFunction.new('isnull', [ cte_table[:id], Arel.sql("0") ])
                )
              )
            )
            .join(Source.transferbasis, Arel::Nodes::OuterJoin).on(Source.transferbasis[:id].eq(Source.movesets[:transferbasis_id]))
            .order(cte_table[:sincedate],Source.movesets[:id], Source.moveitems[:id])
        end

        begin
          sql = ""
          selects = [] 
          unions = []
          
          #condition =<<~SQL
          #  ___moving_operations.movetype_name = values_table.movetype_name
          #    and isnull(___moving_operations.sincedate, '19000101') = isnull(values_table.sincedate, '19000101')
          #    and isnull(___moving_operations.enddate, '19000101') = isnull(values_table.enddate, '19000101')
          #    and isnull(___moving_operations.moveperiod_id, 0) = isnull(values_table.moveperiod_id, 0)
          #    and isnull(___moving_operations.moveset_id, 0) = isnull(values_table.moveset_id, 0)
          #    and isnull(___moving_operations.client_id, 0) = isnull(values_table.client_id, 0)
          #    and isnull(___moving_operations.object_id, 0) = isnull(values_table.object_id, 0)
          #    and isnull(___moving_operations.docset_id, 0) = isnull(values_table.docset_id, 0)
          #    and isnull(___moving_operations.___agreement_id, 0) = isnull(values_table.___agreement_id, 0)
          #    and isnull(___moving_operations.___paycard_id, 0) = isnull(values_table.___paycard_id, 0)
          #SQL

          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            rows.each do |row|
              Arel::SelectManager.new.tap do |select|
                selects <<
                  select.project([
                    Arel::Nodes::Quoted.new(row["movetype_name"]),
                    Arel::Nodes::Quoted.new(row["sincedate"].nil? ? nil : row["sincedate"].strftime("%Y%m%d")),
                    Arel::Nodes::Quoted.new(row["enddate"].nil? ? nil : row["enddate"].strftime("%Y%m%d")),
                    Arel::Nodes::Quoted.new(row["moveperiod_id"]),
                    Arel::Nodes::Quoted.new(row["prev_moveperiod_id"]),
                    Arel::Nodes::Quoted.new(row["parent_moveperiod_id"]),
                    Arel::Nodes::Quoted.new(row["moveset_id"]),
                    Arel::Nodes::Quoted.new(row["client_id"]),
                    Arel::Nodes::Quoted.new(row["moveitem_id"]),
                    Arel::Nodes::Quoted.new(row["docset_id"]),
                    Arel::Nodes::Quoted.new(row["___agreement_id"]),
                    Arel::Nodes::Quoted.new(row["___paycard_id"]),
                    Arel::Nodes::Quoted.new(row["transferbasis_name"]),
                  ])
              end
            end  
            unions << Arel::Nodes::UnionAll.new(selects[0], selects[1])
            selects[2..-1].each do |select| 
              unions << Arel::Nodes::UnionAll.new(unions.last, select)
            end
            insert_manager = Arel::InsertManager.new(Database.source_engine).tap do |manager|
              rows.first.keys.each do |column|
                manager.columns << Source.___moving_operations[column.to_sym]
              end
              manager.into(Source.___moving_operations)
              manager.select(unions.last)
            end
            sql = insert_manager.to_sql

            #sql = Source::MovingOperations.insert_query(rows: insert, condition: condition)
            result = Source.execute_query(sql)
            result.do
            selects.clear
            unions.clear
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
