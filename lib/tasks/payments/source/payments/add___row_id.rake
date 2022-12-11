namespace :payments do
  namespace :source do
    namespace :payments do

      task :add___row_id do |t|
        begin
          sql = Arel.sql(
            "alter table #{ Source.payments.name }
              add ___row_id uniqueidentifier
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
