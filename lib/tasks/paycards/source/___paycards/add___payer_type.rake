namespace :paycards do
  namespace :source do
    namespace :___paycards do

      task :add___payer_type do |t|
        begin
          sql = Arel.sql(
            "alter table #{ Source.___paycards.name }
              add ___payer_type varchar(10)
            "
          )
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
