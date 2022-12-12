namespace :agreements do
  namespace :source do
    namespace :___agreements do

      task :update___link_type do |t|

        def query
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

          select = 
            Source.movesets
            .project(
              Source.movesets[:___agreement_id],
              Source.___ids[:link_type],
            )
            .distinct
            .join(cte_table).on(cte_table[:moveset_id].eq(Source.movesets[:id]))
            .join(Source.moveitems, Arel::Nodes::OuterJoin).on(Source.moveitems[:moveperiod_id].eq(cte_table[:id]))
            .join(Source.___ids).on(Source.___ids[:id].eq(Source.moveitems[:object_id]).and(Source.___ids[:table_id].eq(Source::Objects.table_id)))
            
          t = select.as('t')
          ___link_type = Arel::Nodes::NamedFunction.new('min', [ t[:link_type] ], '___link_type')
          all = Arel::Nodes::NamedFunction.new('count', [ Arel.star ])

          select0 = Arel::SelectManager.new
          select0.project(
            t[:___agreement_id],
            ___link_type, 
          )
          select0.from(t)
          select0.with(moveperiods_cte)
          select0.group(t[:___agreement_id])
          .having(all.eq(1))
          select0.to_sql
        end

        begin
          sql = <<~SQL
            if object_id('tempdb..#values_table') is not null drop table #values_table
            create table #values_table(___agreement_id int, ___link_type int)

            ;#{query.gsub('SELECT t.[___agreement_id], min(t.[link_type]) AS ___link_type', 'insert into #values_table(___agreement_id, ___link_type) SELECT t.[___agreement_id], min(t.[link_type]) AS ___link_type')}
            
            update ___agreements set 
              ___agreements.___link_type = #values_table.___link_type
            from ___agreements
              join #values_table on #values_table.___agreement_id = ___agreements.id

            drop table #values_table
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
