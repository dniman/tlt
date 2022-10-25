namespace :agreements do
  namespace:source do
    namespace :movesets do

      task :add___agreement_id do |t|
        begin
          sql = Arel.sql(
            "alter table #{ Source.movesets.name }
              add ___agreement_id int
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
