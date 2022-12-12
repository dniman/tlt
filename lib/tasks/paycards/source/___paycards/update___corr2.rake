namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update___corr2 do |t|

        def query
          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___paycards[:id],
            Arel::Nodes::Case.new
              .when(Source.___paycards[:client_id2].eq(Destination.link_mo)).then(Destination.link_mo)
              .when(Source.___paycards[:client_id2].eq(nil)).then(nil)
              .else(Source.___ids[:link])
            .as("___corr2"),
          ])
          manager.from(Source.___paycards)
          manager.join(Source.___ids, Arel::Nodes::OuterJoin).on(
            Source.___ids[:id].eq(Source.___paycards[:client_id2])
            .and(Source.___ids[:table_id].eq(Source::Clients.table_id))
          )
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update ___paycards set 
              ___paycards.___corr2 = values_table.___corr2
            from ___paycards
              join (
                #{ query }
              ) values_table(id, ___corr2) on values_table.id = ___paycards.id
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
