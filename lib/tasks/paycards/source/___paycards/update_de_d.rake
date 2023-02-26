namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update_de_d do |t|
        def query
          de_d =
            Arel::Nodes::Case.new()
            .when(Source.___paycards[:de_d].not_eq(nil)
              .and(Source.___paycards[:___name_type_a].does_not_match('Неосновательное обогащение%')
                .or(Source.___paycards[:___name_type_a].matches('Неосновательное обогащение%')
                  .and(Source.___paycards[:___name_objtype].eq(nil)
                    .or(Source.___paycards[:___name_objtype].not_eq('Земельные участки'))
                  )
                )
              )
              .and(Source.___paycards[:nach_p].not_eq(5).or(Source.___paycards[:nach_p].not_eq(6)))
            ).then(Arel::Nodes::Subtraction.new(Source.___paycards[:de_d], 1))
            .else(Source.___paycards[:de_d])
            
          manager = Arel::UpdateManager.new(Database.source_engine)
          manager.set([[Source.___paycards[:de_d],de_d]])
          manager.table(Source.___paycards)
          manager.to_sql
        end

        begin
          Source.execute_query(query)

          Rake.info "Задача '#{ t }' успешно выполнена."
        rescue StandardError => e
          Rake.error "Ошибка при выполнении задачи '#{ t }' - #{e}."
          Rake.info "Текст запроса \"#{ query }\""

          exit
        end
      end

    end
  end
end
