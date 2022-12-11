namespace :payments do
  namespace :source do
    namespace :payments do

      task :add___income_code do |t|
        begin
          sql = Arel.sql(
            "alter table #{ Source.payments.name }
              add ___income_code varchar(30)
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
