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
              Source.moveitems[:object_id],
              Source.movesets[:docset_id],
              Source.movesets[:___agreement_id],
              manager.as("___paycard_id"),
              Source.movesets[:transferbasis_id],
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
            .order(cte_table[:sincedate],Source.movesets[:id], Source.moveitems[:object_id])
        end

        begin
          sql = ""
          insert = []

          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            rows.each do |row|
              insert << {
                movetype_name: row["movetype_name"],
                sincedate: row["sincedate"].nil? ? nil : row["sincedate"].strftime("%Y%m%d"),
                enddate: row["enddate"].nil? ? nil : row["enddate"].strftime("%Y%m%d"),
                moveperiod_id: row["moveperiod_id"],
                prev_moveperiod_id: row["prev_moveperiod_id"],
                parent_moveperiod_id: row["parent_moveperiod_id"],
                moveset_id: row["moveset_id"],
                client_id: row["client_id"],
                object_id: row["object_id"],
                docset_id: row["docset_id"],
                ___agreement_id: row["___agreement_id"],
                ___paycard_id: row["___paycard_id"],
                transferbasis_id: row["transferbasis_id"],
              }
            end

            condition =<<~SQL
              ___moving_operations.movetype_name = values_table.movetype_name
                and isnull(___moving_operations.sincedate, '19000101') = isnull(values_table.sincedate, '19000101')
                and isnull(___moving_operations.enddate, '19000101') = isnull(values_table.enddate, '19000101')
                and isnull(___moving_operations.moveperiod_id, 0) = isnull(values_table.moveperiod_id, 0)
                and isnull(___moving_operations.moveset_id, 0) = isnull(values_table.moveset_id, 0)
                and isnull(___moving_operations.client_id, 0) = isnull(values_table.client_id, 0)
                and isnull(___moving_operations.object_id, 0) = isnull(values_table.object_id, 0)
                and isnull(___moving_operations.docset_id, 0) = isnull(values_table.docset_id, 0)
                and isnull(___moving_operations.___agreement_id, 0) = isnull(values_table.___agreement_id, 0)
                and isnull(___moving_operations.___paycard_id, 0) = isnull(values_table.___paycard_id, 0)
            SQL

            sql = Source::MovingOperations.insert_query(rows: insert, condition: condition)
            result = Source.execute_query(sql)
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
