namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update___link_up do |t|

        def query
          ___paycards2 = Source.___paycards.alias("___paycards2")
          obligation_id =  Arel::Nodes::NamedFunction.new('isnull', [ Source.___paycards[:obligation_id], Arel.sql("0") ]) 
          obligation_id2 =  Arel::Nodes::NamedFunction.new('isnull', [___paycards2[:obligation_id], Arel.sql("0") ]) 
        
          Source.___paycards
          .project([
            Source.___paycards[:id],
            Source.___ids[:link].as("___link_up"),
          ])
          .join(___paycards2, Arel::Nodes::OuterJoin).on(
            ___paycards2[:moveperiod_id].eq(Source.___paycards[:parent_moveperiod_id])
            .and(___paycards2[:moveset_id].eq(Source.___paycards[:moveset_id]))
            .and(obligation_id2.eq(obligation_id))
          )
          .join(Source.___ids, Arel::Nodes::OuterJoin).on(
            Source.___ids[:id].eq(___paycards2[:id])
            .and(Source.___ids[:table_id].eq(Source::Paycards.table_id))
          )
          .where(Source.___paycards[:prev_moveperiod_id].not_eq(nil))
        end

        begin
          sql=<<~SQL
            update ___paycards set 
              ___paycards.___link_up = values_table.___link_up
            from ___paycards
              join(
                #{ query.to_sql }
              ) values_table(id, ___link_up) on values_table.id = ___paycards.id
            where ___paycards.id = values_table.id
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
