namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update___link_type_a do |t|

        def query
          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___ids[:link].as("___link_a"),
            Source.___ids[:link_type].as("___link_type_a"),
          ])
          manager.from(Source.___paycards)
          manager.join(Source.___ids).on(
            Source.___ids[:id].eq(Source.___paycards[:___agreement_id])
            .and(Source.___ids[:table_id].eq(Source::Agreements.table_id))
          )
          manager.to_sql
        end

        begin
          sql=<<~SQL
            update ___paycards set
              ___paycards.___link_type_a = values_table.___link_type_a
            from ___paycards
              join (
                #{ query }
              ) values_table(___link_a, ___link_type_a) on values_table.___link_a = ___paycards.___link_a
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
