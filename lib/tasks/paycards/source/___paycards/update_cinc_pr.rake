namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update_cinc_pr do |t|
        def query
          cinc_p =
            Arel::Nodes::Case.new()
            .when(Source.___paycards[:cinc_pr].eq(nil).and(Source.___paycards[:___name_type_a].eq('Неосновательное обогащение (ГС)')))
              .then('91411607090041000140')
            .when(Source.___paycards[:cinc_pr].eq(nil).and(Source.___paycards[:___name_type_a].eq('Неосновательное обогащение (МС)')))
              .then('91411607090042000140')
            .else(Source.___paycards[:cinc_pr])

          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___paycards[:id],
            cinc_p.as("cinc_pr"),
          ])
          manager.from(Source.___paycards)
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update ___paycards set 
              ___paycards.cinc_pr = values_table.cinc_pr
            from ___paycards
              join (
                #{ query }
              ) values_table(id, cinc_pr) on values_table.id = ___paycards.id
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
