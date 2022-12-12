namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update___status do |t|
        
        def query
          status =
            Arel::Nodes::Case.new()
            .when(
              Source.___paycards[:in_progress].eq('Y')
              .and(
                Source.___agreements[:___docstate_name].not_eq('Архивный, прекращен')
                .or(Source.___agreements[:___docstate_name].not_eq('Архив ПК Земля'))
                .or(Source.___agreements[:___docstate_name].not_eq('прекращен'))
                .or(Source.___agreements[:___docstate_name].not_eq('расторгнут'))
              )
            ).then(1)
            .when(
              Source.___paycards[:in_contract].eq('Y')
              .or(Source.___agreements[:___docstate_name].eq('Архивный, прекращен'))
              .or(Source.___agreements[:___docstate_name].eq('Архив ПК Земля'))
              .or(Source.___agreements[:___docstate_name].eq('прекращен'))
              .or(Source.___agreements[:___docstate_name].eq('расторгнут'))
            ).then(3)
            .else(2)

          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___paycards[:id],
            status.as("___status"),
          ])
          manager.from(Source.___paycards)
          manager.join(Source.___agreements).on(Source.___agreements[:id].eq(Source.___paycards[:___agreement_id]))
        end

        begin
          sql =<<~SQL
            if object_id('tempdb..#statuses') is not null drop table #statuses
            create table #statuses(id int, ___status int)
            insert into #statuses(id, ___status)
            #{query.to_sql}

            update ___paycards set 
              ___paycards.___status = #statuses.___status
            from ___paycards, #statuses
            where ___paycards.id = #statuses.id

            update ___paycards set
              ___paycards.___status = paycards.___status
            from ___paycards
              join ___paycards paycards on paycards.moveperiod_id = ___paycards.parent_moveperiod_id and paycards.prev_moveperiod_id is null
            where ___paycards.prev_moveperiod_id is not null

            drop table #statuses
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
