namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update_de_d2 do |t|
        def query
          de_d = Arel.sql("31")
            
          manager = Arel::UpdateManager.new(Database.source_engine)
          manager.set([[Source.___paycards[:de_d], de_d]])
          manager.table(Source.___paycards)
          manager.where(
            Source.___paycards[:de_d].eq(0)
            .and(Source.___paycards[:de_t].eq(2))
            .and(Source.___paycards[:___name_type_a].does_not_match('Неосновательное обогащение%')
              .or(Source.___paycards[:___name_type_a].matches('Неосновательное обогащение%')
                .and(Source.___paycards[:___name_objtype].eq(nil)
                  .or(Source.___paycards[:___name_objtype].not_eq('Земельные участки'))
                )
              )
            )
            #.and(Source.___paycards[:nach_p].not_eq(5).or(Source.___paycards[:nach_p].not_eq(6)))
          )
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
