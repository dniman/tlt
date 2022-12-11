namespace :payments do
  namespace :source do
    namespace :payments do

      task :add___income do |t|
        begin
          sql = Arel.sql(
            "alter table #{ Source.payments.name }
              add ___income int
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
