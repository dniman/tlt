namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :update___sum_rtype do |t|

        def query
          sum_rtype =
            Arel::Nodes::Case.new()
            .when(Source.___paycards[:___name_type_a].matches("%купли-продажи%")).then(nil)
            .when(Source.___paycards[:___name_type_a].eq("Договор аренды недвижимого имущества")).then(1)
            .when(Source.___paycards[:___name_type_a].eq("Договор аренды движимого имущества")).then(1)
            .else(Arel.sql("2"))

          manager = Arel::SelectManager.new(Database.source_engine)
          manager.project([
            Source.___paycards[:id],
            sum_rtype.as("___sum_rtype"),
          ])
          manager.from(Source.___paycards)
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update ___paycards set 
              ___paycards.___sum_rtype = values_table.___sum_rtype
            from ___paycards
              join(
                #{ query }
              )values_table(id, ___sum_rtype) on values_table.id = ___paycards.id
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
