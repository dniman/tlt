namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update_su_d do |t|
        def query
          su_d =
            Arel::Nodes::Case.new()
            .when(Source.___paycards[:su_d].not_eq(nil)
              .and(Source.___paycards[:su_d].gt(1))
              .and(Source.___paycards[:___name_type_a].matches('Неосновательное обогащение%'))
            ).then(Arel::Nodes::Subtraction.new(Source.___paycards[:su_d], 1))
            
          manager = Arel::UpdateManager.new(Database.source_engine)
          manager.set([[Source.___paycards[:su_d], su_d]])
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
