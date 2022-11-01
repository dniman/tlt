namespace :agreements do
  namespace :source do
    namespace :___agreements do

      task :add___ground_owner_count do |t|
        begin
          sql = Arel.sql(
            "alter table #{ Source.___agreements.name }
              add ___ground_owner_count int
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
