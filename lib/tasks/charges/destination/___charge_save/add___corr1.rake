namespace :charges do
  namespace :destination do
    namespace :___charge_save do

      task :add___corr1 do |t|
        begin
          sql = Arel.sql(
            "alter table #{ Destination.___charge_save.name }
              add ___corr1 int
            "
          )
          Destination.execute_query(sql).do

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
